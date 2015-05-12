/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/


var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');


function parseArgs(args) {
    var a = [];
    a.push(args.mimeTypes || null);
    a.push(args.services || null);
    a.push(args.multiple || null);
    a.push(args.maxFiles || null);
    a.push(args.maxSize || null);
    return a;
}    
    
function parseStoreArgs(args) {
    var a = [];
    a.push(args.location || null);
    a.push(args.path || null);
    a.push(args.container || null);
    a.push(args.access || null);
    return a;
}    
    
var filepickerio = {
    /**
     * Set the API key
     * @param key
     */
    setKey:function(key) {
        exec(null, null, 'filepickerio', 'setKey', [key]);
    },
    /**
     * Set the app name
     * @param name
     */
    setName:function(name) {
        exec(null, null, 'filepickerio', 'setName', [name]);
    },
    /**
     * Pick a file
     * @param pickerOptions options
     * @param successCB success callback
     * @param errorCB error callback
     * @return file
     */
    pick:function(pickerOptions, successCB, errorCB) {
        pickerOptions.multiple = false;
        exec(function(files) {
            successCB && successCB(files[0]);
        }, errorCB, 'filepickerio', 'pick', parseArgs(pickerOptions));
    },
    /**
     * Pick multiple files
     * @param pickerOptions options
     * @param successCB success callback
     * @param errorCB error callback
     * @return files
     */
    pickMultiple:function(pickerOptions, successCB, errorCB) {
        pickerOptions.multiple = true;
        exec(successCB, errorCB, 'filepickerio', 'pick', parseArgs(pickerOptions));
    },
    /**
     * Pick and store a file
     * @param pickerOptions options
     * @param storeOptions options
     * @param successCB success callback
     * @param errorCB error callback
     * @return files
     */
    pickAndStore:function(pickerOptions, storeOptions, successCB, errorCB) {
        exec(successCB, errorCB, 'filepickerio', 'pickAndStore', parseArgs(pickerOptions).concat(parseStoreArgs(storeOptions)));
    }
};

module.exports = filepickerio;
