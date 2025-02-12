﻿import { InitParser } from '../classes/init-parser';

import { ActionStatus } from '../enums/action-status';
import { DataStoreType } from '../enums/data-store-type';
import { ExperienceType } from '../enums/experience-type';

import { ActionResponse } from '../models/action-response';

import { MainService } from './main-service';

export class DeploymentService {
    MS: MainService;
    actions: any[] = [];
    executingIndex: number = -1;
    executingAction: any = {};
    experienceType: ExperienceType;
    hasError: boolean = false;
    isFinished: boolean = false;
    message: string = '';
    progressPercentage: number = 0;

    constructor(MainService) {
        this.MS = MainService;
    }

    async ExecuteActions(): Promise<boolean> {
        if (this.experienceType === ExperienceType.uninstall) {
            this.MS.LoggerService.TrackUninstallStart();
        }
        if (this.experienceType === ExperienceType.install) {
            this.MS.LoggerService.TrackDeploymentStart();
        }

        let lastActionStatus: ActionStatus = ActionStatus.Success;
        this.MS.DataStore.DeploymentIndex = '';
        this.progressPercentage = 0;

        for (let i = 0; i < this.actions.length && !this.hasError; i++) {
            this.MS.DataStore.DeploymentIndex = i.toString();
            this.executingIndex = i;
            this.executingAction = this.actions[i];
            this.progressPercentage = i / this.actions.length * 100;

            let param: any = {};
            if (lastActionStatus !== ActionStatus.BatchWithState) {
                param = this.actions[i].AdditionalParameters;
            }

            InitParser.loadVariables(param, param, this.MS, this);

            // Skip action if requested to do so by variable
            if (param && param.skip && param.skip.toLowerCase() === 'true') {
                continue;
            }

            this.MS.LoggerService.TrackDeploymentStepStartEvent(i, this.actions[i].OperationName);
            let response = await this.MS.HttpService.executeAsync(this.actions[i].OperationName, param);
            this.message = '';

            this.MS.LoggerService.TrackDeploymentStepStoptEvent(i, this.actions[i].OperationName, response.IsSuccess);

            if (!(response.IsSuccess)) {
                this.hasError = true;
                break;
            }

            this.MS.DataStore.addObjectToDataStore(response.Body, DataStoreType.Private);
            if (response.Status === ActionStatus.BatchWithState ||
                response.Status === ActionStatus.BatchNoState) {
                i = i - 1; // Loop again but dont add parameter back
            }

            lastActionStatus = response.Status;
        }

        this.MS.DataStore.DeploymentIndex = '';
        if (this.hasError) {
            this.message = 'Error';
        } else {
            this.executingAction = {};
            this.executingIndex++;
            this.message = 'Success';
            this.progressPercentage = 100;
        }

        if (this.experienceType === ExperienceType.uninstall) {
            this.MS.LoggerService.TrackUninstallEnd(!this.hasError);
        }
        if (this.experienceType === ExperienceType.install) {
            this.MS.LoggerService.TrackDeploymentEnd(!this.hasError);
        }
        this.isFinished = true;

        if (this.experienceType === ExperienceType.uninstall && !this.hasError) {
            this.MS.HttpService.Close();
        }

        return !this.hasError;
    }
}