# Filepicker.io 

Plugin for Cordova / PhoneGap to use the [native android SDK](https://github.com/Ink/filepicker-android) of [Filepicker.io](https://www.filepicker.com) 

iOS is not supported so far, open an issue if you want me to support it.

## Installing the plugin ##
```
cordova plugin add https://github.com/dbaq/cordova-plugin-filepickerio.git --save
```

There is a (temporary) step to add to your build.gradle (if cordova > 5.0.0)

in platforms/android/build.gradle, you need to add the following line after the line 247 (in ```dependencies {}```)

```compile 'io.filepicker:filepicker-android:3.8.13'```

waiting for a solution [here](https://stackoverflow.com/questions/30130838/cordova-plugin-add-external-aar-file-not-jar)

## Using the plugin ##
The plugin creates the object `window.filepicker` with the following functions available:

 * `filepicker.setKey(key)`
 * `filepicker.setName(app_name)`
 * `filepicker.pick(picker_options, onSuccess(Blob){}, onError(FPError){})`
 * `filepicker.pickMultiple(picker_options, onSuccess(Blobs){}, onError(FPError){})`
 * `filepicker.pickAndStore(picker_options, store_options, onSuccess(Blobs){}, onError(FPError){})`

### Response format ##
 * container - container in S3 where the file was stored (if it was stored)
 * url - file link to uploaded file
 * filename - name of file
 * localPath - local path of file
 * key - unique key
 * mimetype - mimetype
 * size - size in bytes

note: pick() returns an object, pickMultiple() and pickAndStore() returns an array of objects

### Picker options available ##
 * ```multiple``` boolean : Getting multiple files
 * ```maxFiles``` integer : Choosing max files
 * ```maxSize``` integer : Choosing max files
 * ```services``` array of strings : Choosing services ```{"GALLERY", "CAMERA", "FACEBOOK", "CLOUDDRIVE", "DROPBOX", "BOX", "GMAIL", "INSTAGRAM", "FLICKR", "PICASA", "GITHUB", "GOOGLE_DRIVE", "EVERNOTE", "SKYDRIVE"}```
 * ```mimeTypes``` array of strings : Choosing mimetypes


### Store options available ##
 * ```location``` string : ```S3```
 * ```path``` string : Choosing the path ```"/example/123.png"```
 * ```container``` string : Bucket
 * ```access``` string :  ```public```

### Security options available ##
Not implemented yet, feel free to contribute. See [native SDK documentation](https://github.com/Ink/filepicker-android#security).

## Full example

A full example could be:

```
function pickFile() {
    window.filepicker.setKey('APP KEY');
    window.filepicker.setName('APP NAME');
    window.filepicker.pickAndStore({
        multiple: true,
        mimeTypes: ['image/*', 'application/pdf'],
        services : [ 'CAMERA', 'GALLERY', 'GOOGLE_DRIVE', 'DROPBOX', 'BOX', 'SKYDRIVE'],
        maxFiles: 20,
        maxSize: (10*1024*1024)
    }, {
        location : 'S3',
        path : '/location/'
    }, function(res) {
        console.log(res);
    }, function(e) {
       console.error(e);
    });
}
```

## Contributing

Thanks for considering contributing to this project.

### Finding something to do

Ask, or pick an issue and comment on it announcing your desire to work on it. Ideally wait until we assign it to you to minimize work duplication.

### Reporting an issue

- Search existing issues before raising a new one.

- Include as much detail as possible.

### Pull requests

- Make it clear in the issue tracker what you are working on, so that someone else doesn't duplicate the work.

- Use a feature branch, not master.

- Rebase your feature branch onto origin/master before raising the PR.

- Keep up to date with changes in master so your PR is easy to merge.

- Be descriptive in your PR message: what is it for, why is it needed, etc.

- Make sure the tests pass

- Squash related commits as much as possible.

### Coding style

- Try to match the existing indent style.

- Don't mix platform-specific stuff into the main code.



## Licence ##

The MIT License

Copyright (c) 2015 Didier Baquier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
