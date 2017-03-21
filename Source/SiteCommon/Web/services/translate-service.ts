import MainService from './mainservice';

import { EN_US } from '../constants/en-us';
import { Language } from '../constants/language';

export class TranslateService {
    language: any = null;
    MS: MainService;

    constructor(MainService: MainService, language: string) {
        this.MS = MainService;
        switch (language) {
            case Language.EN_US:
                this.language = EN_US;
                break;
            default:
                this.language = EN_US;
        }
    }
}