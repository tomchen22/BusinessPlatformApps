import { DataStore, DataStoreType } from '../services/datastore';

export class ActionRequest {
    public DataStore: DataStore;

    constructor(parameters: any, datastore: DataStore) {
        this.DataStore = datastore;

        // Read the parameters and ensure the datastore is set up correctly
        // We may need to clone the datastore but for now we won't

        // Delete the RequestParameters from the old request
        this.DataStore.PrivateDataStore.remove('RequestParameters');

        // Add object to data store
        this.DataStore.addObjectToDataStoreWithCustomRoute('RequestParameters', parameters, DataStoreType.Private);
    }
}