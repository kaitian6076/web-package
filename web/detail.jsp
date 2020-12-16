<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.PackageUtil" %>

<%

    String packageName = request.getParameter("packageName");

    String versionCode;
    String[] versionCodeArray = request.getParameterValues("versionCode");

    if (versionCodeArray.length == 1) {
        versionCode = versionCodeArray[0];
    } else if (versionCodeArray.length == 2) {
        versionCode = versionCodeArray[0] + "+" + versionCodeArray[1];
    } else {
        versionCode = request.getParameter("versionCode");
    }


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
            document.getElementById("detailBodyContainer").style.minHeight = (window.innerHeight + 10).toString() + "px"
            document.getElementById("detailBodyContainer").style.background = "linear-gradient(#6495ed, #FDF5E6, #6495ed)"

            document.getElementById("divDetailHeader").style.display = "block";

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

<body id="detailBodyContainer">


<div style="margin: 0 auto; width: 900px;">

    <div id="divDetailHeader" style="display: none">
        <div style="text-align: center; font-size: 21px; font-weight: bold; margin-top: 13px"><%=packageName%> - <%=versionCode%>
        </div>

<%--        <div style="text-align: center; font-size: 19px; margin-top: 3px">--%>
<%--        </div>--%>
    </div>


    <div id="divDetailContainer" style="display: none">


        <div style="font-size: 19px; font-weight: bold; margin-top: 8px; margin-left: 10px">
            Information
        </div>

        <div id="informationDivId" style="background: whitesmoke;
     padding: 10px 20px 12px 20px; margin: 13px 0px 0px 0px; border-radius: 6px">

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


        <div style="font-size: 19px; font-weight: bold; margin-top: 30px; margin-left: 10px">
            README.md
        </div>

        <div id="readmeDivId" style="background: whitesmoke;
     padding: 10px 20px 20px 20px; margin: 15px 0px 0px 0px; border-radius: 6px">

        </div>


        <div style="font-size: 19px; font-weight: bold; margin-top: 30px; margin-left: 10px">
            CHANGELOG.md
        </div>

        <div id="changelogDivId" style="background: whitesmoke;
     padding: 10px 20px 20px 20px; margin: 15px 0px 35px 0px; border-radius: 6px">

        </div>


    </div>


</div>

</body>
</html>
