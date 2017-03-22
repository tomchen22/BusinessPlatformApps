import { VariableType } from '../enums/variable-type';

export class Variable {
    value: any = '';
    secondArgument: string = '';
    saveToDataStore: boolean = false;
    varType: VariableType;
}