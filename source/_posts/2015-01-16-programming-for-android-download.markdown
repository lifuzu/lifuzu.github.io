---
layout: post
title: "Programming for Android: Download, Progressbar and FileProvider"
date: 2015-01-16 17:50:20 -0800
comments: true
categories: development 
---
![enter image description here](https://turbotax.intuit.com/handlebars/noncampaign/hp/images/melissa-tablet.jpg)
In this article, we try to download a file from Internet, show the progress of downloading, then share the file to gallery for displaying with FileProvider.

**Keywords**: Android, Programming, Download, Image, Progressbar, FileProvider

**Prerequisites**:

*0*. Create an Android project with name: FileProviderExample, you can also clone this project directly from github here: [[3](https://github.com/lifuzu/FileProviderExample)]


**Steps**:

*1*. Download

We intend to download an image file with foreground mode since we want to block the consequent actions until the download process is complete. If you try to download file(s) with background mode, please reference some other articles [here](http://stackoverflow.com/questions/3028306/download-a-file-with-android-and-showing-the-progress-in-a-progressdialog)
<!--more-->
Update the activity layout file `res/layout/activity_main.xml` to add a button for downloading:
```xml
    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:id="@+id/btnDownload"
        android:onClick="startDownload"
        android:text="Download Image"/>
```
With the above update, we need to define a function named `startDownload` to trigger the download process:
```java
    public void startDownload(View view) {
        download("http://farm1.static.flickr.com/114/298125983_0e4bf66782_b.jpg", "abc.jpg");
    }
```
Here we download an image from the above URL, and save it to direct local path with the name `abc.jpg`.

We design the download interface with a simple way. For the download function, what we want is a URL then a local file path that we saved the URL:
```java
protected void download(final String strUrl, final String fileName)
```

With the `Thread` support, we create the download precedure:
```java
    new Thread(new Runnable() {
            @Override
            public void run() {
                File file = new File(getFilesDir(), fileName);

                try {
                    URL url = new URL(strUrl);
                    Log.i("FILE_NAME", "File name is " + fileName);
                    Log.i("FILE_URL", "File URL is " + url);
                    URLConnection connection = url.openConnection();
                    connection.connect();
                    // get the file length
                    int fileLength = connection.getContentLength();

                    // download the file
                    InputStream input = new BufferedInputStream(url.openStream());
                    OutputStream output = new FileOutputStream(file);

                    byte data[] = new byte[1024];
                    long total = 0;
                    int count;
                    while ((count = input.read(data)) != -1) {
                        total += count;
                        // increase progress bar here
                        // write data into file
                        output.write(data, 0, count);
                    }

                    // flush output and close streams
                    output.flush();
                    output.close();
                    input.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    Log.i("ERROR ON DOWNLOADING FILES", "ERROR IS" + e);
                }
            }
        }).start();
```
From the above code, we save the file just direct local path, without any more directory:
```java
                File file = new File(getFilesDir(), fileName);
```
And then we call `URLConnection` to connect the URL which we want to download:
```java
                    URL url = new URL(strUrl);
                    URLConnection connection = url.openConnection();
                    connection.connect();
```
Read the input stream write to output stream recursively, until the input stream reach the end:
```java
                    InputStream input = new BufferedInputStream(url.openStream());
                    OutputStream output = new FileOutputStream(file);

                    byte data[] = new byte[1024];
                    long total = 0;
                    int count;
                    while ((count = input.read(data)) != -1) {
                        total += count;
                        output.write(data, 0, count);
                    }
```
Then flush the output incase some data left in memory, and close the streams:
```java
                    output.flush();
                    output.close();
                    input.close();
```
One more thing before compiling a successful application is to check permission, we need an Internet permission to download the image. We need to add the permission into `manifests/AndroidManifest.xml`:
```xml
    <uses-permission android:name="android.permission.INTERNET"></uses-permission>
```
To verify the download function, run the application on Android device, click the button `DOWNLOAD IMAGE`
![enter image description here](https://lh4.googleusercontent.com/ttxff19bogmzdV1aX7HC-JsiB4w0irGnqvj1Z3JPf-4=s600 "Screen Shot 2015-01-16 at 10.08.35 AM.png")
Nothing seems happen, since we do not have any vision way to indicate the download progress is completed right now. For verification, we need adb to enter Android file system to have a file check.
```bash
$ adb devices
$ adb shell
root@vbox86tp:/ #  ls /data/data/com.example.rlee.fileproviderexample/files/
abc.jpg
```
Cool, the file `abc.jpg` is downloaded from the URL `http://farm1.static.flickr.com/114/298125983_0e4bf66782_b.jpg`. You even would like to pull the file into desktop then have an exact content check:
```bash
$ adb pull /data/data/com.example.rlee.fileproviderexample/files/abc.jpg
```
Then open it in File Explorer (like Finder for Mac OS), and open the URL in brower (like Chrome) to have a comparison.

*2*. Progressbar to show the status of download

To display the status of downloading, we need ProgressDialog component, which will show a progress indicator and an optional text message or view.

We need add a declaration for the ProgressDialog in the class `MainActivity`:
```java
    // Progress Bar
    ProgressDialog progressDialog;
```
Initialize the variable with activity instance under the function `onCreate`:
```java
        progressDialog = new ProgressDialog(MainActivity.this);
```
When we start to download the image, we need to set the initial state for the progress bar:
```java
        progressDialog.setTitle("Downloading Image ...");
        progressDialog.setMessage("Download in progress ...");
        progressDialog.setProgressStyle(progressDialog.STYLE_HORIZONTAL);
        progressDialog.setProgress(0);
        progressDialog.setMax(100);
        progressDialog.show();
```
And we have the image size which we will download:
```java
                    // get the file length
                    int fileLength = connection.getContentLength();
```
After we read and write some partial data, we update the state for progress bar:
```java
                        // increase progress bar here
                        progressDialog.setProgress((int)(total*100)/fileLength);
```
At last, when we complete the download, we dismiss the progress bar:
```java
                    // dismiss the progress bar
                    progressDialog.dismiss();
```
To verify the progress bar, try to find a big jpg image file on Internet, then replace the URL in download function. 
Run the application on Android device, click the button `DOWNLOAD IMAGE` again, you should see the progressbar like this:
![enter image description here](https://lh4.googleusercontent.com/-dqDPYup6e6w/VLlh3vI0zlI/AAAAAAAACuE/kbQ1Gxy6Kv0/s600/Screen+Shot+2015-01-16+at+11.08.44+AM.png "Screen Shot 2015-01-16 at 11.08.44 AM.png")

*3*. Show the file with FileProvider

Android do NOT allow apps to access the private folder of another application. To share our downloaded image, we have to offer the image to other applications from our side. With FileProvider, we can share the file in my own app domain to other apps.

For FileProvider, we need to add the provider element in android manifest file `manifests/AndroidManifest.xml`:
```xml
        <provider
            android:authorities="com.example.rlee.fileproviderexample.fileprovider"
            android:name="android.support.v4.content.FileProvider"
            android:grantUriPermissions="true"
            android:exported="false">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/filepaths" />
        </provider>
```
then add a new file under `res/xml` with the name `filepaths.xml` (create the xml folder if it does not exist), with the content:
```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <files-path path="." name="image" />
</paths>
```
Add another button to trigger an intent to display the image in `res/layout/activity_main.xml`:
```xml
    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:id="@+id/btnDisplay"
        android:onClick="startDisplay"
        android:text="Display Image......"/>
```
Create the function `startDisplay`, which defined in the above code:
```java
    public void startDisplay(View view) {
        // show jpg in gallery
        File file = new File(getFilesDir(), "abc.jpg");
        Uri fileUri = FileProvider.getUriForFile(this, "com.example.rlee.fileproviderexample.fileprovider", file);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(fileUri, "image/*");
        intent.addFlags(
                Intent.FLAG_GRANT_READ_URI_PERMISSION);
        Log.i("FILE_URI", "File Uri is " + Uri.fromFile(file));
        startActivity(intent);
    }
```
To verify the display function, run the application on Android device, click the button `DISPLAY IMAGE ......`
![enter image description here](https://lh5.googleusercontent.com/-9CgNpo_-BFI/VLlT17IEKMI/AAAAAAAACtc/O2ec7Ia5Uj0/s600/Screen+Shot+2015-01-16+at+10.08.35+AM.png "Screen Shot 2015-01-16 at 10.08.35 AM.png")
Then the image will be displayed by the Android Gallery application:
![enter image description here](https://lh6.googleusercontent.com/-X3R3BNX123M/VLlUKn-K1EI/AAAAAAAACto/IHuToVCF8wI/s600/Screen+Shot+2015-01-16+at+10.08.56+AM.png "Screen Shot 2015-01-16 at 10.08.56 AM.png")

If you have any question, please add comments below or submit issues [here](https://github.com/lifuzu/FileProviderExample/issues).

Have fun to try!

**Tips**:
[Genymotion](https://www.genymotion.com/?utm_source=dlvr.it&utm_medium=twitter#!/product) might be your friend.

**References**:

1. https://developer.android.com/training/secure-file-sharing/setup-sharing.html
2. https://developer.android.com/training/secure-file-sharing/share-file.html
3. https://github.com/lifuzu/FileProviderExample
4. http://stackoverflow.com/questions/3028306/download-a-file-with-android-and-showing-the-progress-in-a-progressdialog

> Written with [StackEdit](https://stackedit.io/).
