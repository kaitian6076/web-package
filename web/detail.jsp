<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.PackageUtil" %>

<%

    String packageName = request.getParameter("packageName");
    String versionCode = request.getParameter("versionCode");

    String basePath = "/Users/kaitian/Desktop/flutter-pub-repository";

    String packageDetailPath = basePath
            + "/" + packageName + "/" + versionCode + "/" + "packageDetail.txt";

    String readmePath = basePath
            + "/" + packageName + "/" + versionCode + "/" + "README.md";

    String changelogPath = basePath
            + "/" + packageName + "/" + versionCode + "/" + "CHANGELOG.md";

    String pubYamlPath = basePath
            + "/" + packageName + "/" + versionCode + "/" + "pubspec.yaml";


    String uploadTime = PackageUtil.getUploadTime(pubYamlPath);

    String packageDetailJson = PackageUtil.getFileContentText(packageDetailPath, true);
    String readmeMd = PackageUtil.getFileContentText(readmePath, false);
    String changelogMd = PackageUtil.getFileContentText(changelogPath, false);


%>


<!DOCTYPE html>
<html>
<head>
    <title>package详情</title>
    <script src="marked.min.js"></script>


    <script type="text/javascript">
        window.onload = function () {
            let uploadTimeText = "<%=uploadTime%>";
            let packageDetailText = "<%=packageDetailJson%>";
            let readmeText = "<%=readmeMd%>";
            let changelogText = "<%=changelogMd%>";

            // console.log("packageDetailText---" + packageDetailText)

            let parseJson = JSON.parse(packageDetailText);

            document.getElementById("spanDescription").innerText = parseJson.description;
            document.getElementById("spanAuthor").innerText = parseJson.author;
            document.getElementById("spanUploadTime").innerText = uploadTimeText;

            document.getElementById("aHomepage").href = parseJson.homepage;
            document.getElementById("aHomepage").innerText = parseJson.homepage;

            document.getElementById("readmeDivId").innerHTML = marked(readmeText);
            document.getElementById("changelogDivId").innerHTML = marked(changelogText);

            document.getElementById("divDetailContainer").style.display = "block";

        };

    </script>

</head>

<body style="background: #6495ed">


<div style="margin: 0 auto; width: 900px;">


    <div style="text-align: center; font-size: 20px; font-weight: bold; margin-top: 10px">package详情
    </div>

    <div style="text-align: center; font-size: 19px; margin-top: 3px"><%=packageName%>
        - <%=versionCode%>
    </div>

    <div id="divDetailContainer" style="display: none">


        <div style="font-size: 19px; font-weight: bold; margin-top: 10px; margin-left: 10px">
            Information
        </div>

        <div id="informationDivId" style="background: whitesmoke;
     padding: 10px 20px 12px 20px; margin: 15px 0px 0px 0px; border-radius: 6px">

            <div>
                <span style="font-weight: bold;">Description: </span>
                <span id="spanDescription" style="word-wrap: break-word"></span>
            </div>

            <div style="margin-top: 5px">
                <span style="font-weight: bold;">Author: </span>
                <span id="spanAuthor" style="word-wrap: break-word"></span>
            </div>

            <div style="margin-top: 5px">
                <span style="font-weight: bold;">Upload time: </span>
                <span id="spanUploadTime" style="word-wrap: break-word"></span>
            </div>

            <div style="margin-top: 5px">
                <span style="font-weight: bold;">Homepage: </span>
                <span style="word-wrap: break-word"><a id="aHomepage"></a></span>
            </div>

        </div>


        <div style="font-size: 19px; font-weight: bold; margin-top: 35px; margin-left: 10px">
            README.md
        </div>

        <div id="readmeDivId" style="background: whitesmoke;
     padding: 10px 20px 20px 20px; margin: 15px 0px 0px 0px; border-radius: 6px">

        </div>


        <div style="font-size: 19px; font-weight: bold; margin-top: 35px; margin-left: 10px">
            CHANGELOG.md
        </div>

        <div id="changelogDivId" style="background: whitesmoke;
     padding: 10px 20px 20px 20px; margin: 15px 0px 35px 0px; border-radius: 6px">

        </div>


    </div>


</div>

</body>
</html>
