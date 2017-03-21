import { VariableType } from '../enums/variable-type';

import { ActionResponse } from '../models/action-response';
import { Variable } from '../models/variable';

import { DataStore, DataStoreType } from '../services/datastore';
import { HttpService } from '../services/httpservice';
import MainService from '../services/mainservice';

export class InitParser {
    public static MS: MainService;

    public static async executeActions(actions: any[], obj: any, MS: MainService, self: any): Promise<boolean> {
        for (let index in actions) {
            let actionToExecute: any = actions[index];
            let name: string = actionToExecute.name;
            if (name) {
                var body = {};
                this.loadVariables(body, actionToExecute, this.MS, self);

                var response: ActionResponse = await this.MS.HttpService.executeAsync(name, body);
                if (!response.IsSuccess) {
                    return false;
                }

                this.MS.DataStore.addObjectToDataStore(response, DataStoreType.Private);
            }
        }

        return true;
    }

    public static loadVariables(objToChange: any, obj: any, MS: MainService, self: any) {
        this.MS = MS;
        for (let propertyName in obj) {
            let val: any = obj[propertyName];
            this.parseVariable(propertyName, val, objToChange, this.MS, self);

            if (val && typeof (val) === 'object' && propertyName !== 'onNext' && propertyName !== 'onValidate') {
                this.loadVariables(objToChange[propertyName], val, this.MS, self);
            }
        }
    }

    // The code to go ahead and parse the Variable
    public static parseVariable(key: string, value: any, obj: any, MS: MainService, self: any) {
        let variable: Variable = this.getVariableType(value);
        let result: string = '';
        let command: string = '';

        if (!variable.secondArgument) {
            variable.secondArgument = '';
        }

        switch (variable.varType) {
            case VariableType.DataStoreGetFirst:
                {
                    command = 'this.MS.DataStore.getJson("' + variable.value + '")' + variable.secondArgument;
                };
                break;
            case VariableType.DatasStoreGetAll:
                {
                    command = 'this.MS.DataStore.getAllJson("' + variable.value + '")' + variable.secondArgument;
                };
                break;
            case VariableType.Run:
                {
                    command = variable.value;
                };
                break;
            case VariableType.RunAndSave:
                {
                    command = variable.value;
                }
                break;
            case VariableType.Static:
                {
                    command = '';
                    result = variable.value;
                }
        }

        if (command) {
            result = eval(command);
        }

        obj[key] = result;
        if (variable.saveToDataStore) {
            MS.DataStore.addToDataStore(key, result, DataStoreType.Private);
        }
    }

    private static getVariableType(value: any): Variable {
        let variable: Variable = new Variable();

        if (!value) {
            variable.varType = VariableType.Static;
            variable.value = value;
            return variable;
        }

        let lowercaseValue: string = value.toString().toLowerCase();

        variable.varType = VariableType.NotValid;

        if (lowercaseValue[0] !== '$') {
            variable.varType = VariableType.Static;
            variable.value = value;
        }

        if (lowercaseValue.startsWith('$ds(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(4);
            value = value.trim();
            let index = value.indexOf(')');
            let dslookup = value.substring(0, index);
            if (value.length >= index + 1) {
                let dslookupSecondArg = value.substring(index + 1);
                variable.secondArgument = dslookupSecondArg;
            }

            variable.varType = VariableType.DataStoreGetFirst;
            variable.value = dslookup;
        }

        if (lowercaseValue.startsWith('$dsall(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(7);
            value = value.trim();
            let index = value.indexOf(')');
            let dslookup = value.substring(0, index);

            if (value.length >= index + 1) {
                let dslookupSecondArg = value.substring(index + 1);
                variable.secondArgument = dslookupSecondArg;
            }

            variable.value = dslookup;
            variable.varType = VariableType.DatasStoreGetAll;
        }

        if (lowercaseValue.startsWith('$run(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(5);
            value = value.substring(0, value.lastIndexOf(')'));
            value = value.trim();
            value = value.replace('this.', 'self.');
            variable.value = value;
            variable.varType = VariableType.Run;
        }

        if (lowercaseValue.startsWith('$translate(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(11);
            value = value.substring(0, value.lastIndexOf(')'));
            value = value.trim();
            value = 'self.MS.Translate.' + value;
            variable.value = value;
            variable.varType = VariableType.Run;
        }

        if (lowercaseValue.startsWith('$(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(2);
            value = value.substring(0, value.lastIndexOf(')'));
            value = value.trim();
            value = this.extractVariable(value);
            value = value.replace('this.', 'self.');
            variable.value = value;
            variable.varType = VariableType.RunAndSave;
            variable.saveToDataStore = this.isPermenantEntryIntoDataStore(value);
        }

        if (lowercaseValue.startsWith('$save(') && lowercaseValue.indexOf(')') >= 0) {
            value = value.substring(6);
            value = value.substring(0, value.lastIndexOf(')'));
            value = value.trim();
            value = value.replace('this.', 'self.');
            variable.value = value;
            variable.saveToDataStore = true;
            variable.varType = VariableType.RunAndSave;
        }

        return variable;
    }

    // old stuff
    public static extractVariable(value: any): string {
        let resultSplit = value.split(',');
        return resultSplit[0].trim();
    }

    public static isPermenantEntryIntoDataStore(value: any): boolean {
        let resultSplit = value.split(',');

        for (let index = 0; index < resultSplit.length; index++) {
            if (index < 1) {
                continue;
            }

            let param: string = resultSplit[index].trim().toLowerCase();
            let paramSplit = param.split('=');

            if (paramSplit[0] === 'issaved' && paramSplit[1] === 'true') {
                return true;
            }
        }

        return false;
    }
}