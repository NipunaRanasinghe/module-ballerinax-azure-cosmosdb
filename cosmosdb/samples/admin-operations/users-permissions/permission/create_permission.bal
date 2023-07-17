// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerina/os;
import ballerinax/azure.cosmosdb;

cosmosdb:ManagementClientConfig config = {
    baseUrl: os:getEnv("BASE_URL"),
    primaryKeyOrResourceToken: os:getEnv("MASTER_OR_RESOURCE_TOKEN")
};

cosmosdb:ManagementClient managementClient = check new (config);

public function main() { 
    string databaseId = "my_database";
    string containerId = "my_container";
    string userId = "my_user";

    string permissionId = "my_permission";
    cosmosdb:PermisssionMode permissionMode = "All";
    string permissionResource = string `dbs/${databaseId}/colls/${containerId}`;
        
    log:printInfo("Create permission for a user");
    cosmosdb:Permission|error result = managementClient->createPermission(databaseId, userId, permissionId, 
        permissionMode, <@untainted>permissionResource);

    if (result is cosmosdb:Permission) {
        log:printInfo(result.toString());
        log:printInfo("Success!");
    } else {
        log:printError(result.message());
    }
}
