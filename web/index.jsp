<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="utils.PackageUtil" %>


<%

    TreeMap<String, List<String>> treeMap = new TreeMap<>();
    LinkedHashMap<String, List<String>> linkedHashMap = new LinkedHashMap<>();

    String path = "/Users/kaitian/Desktop/flutter-pub-repository";

    PackageUtil.getFilePath(path, treeMap);

//    System.out.println(treeMap.toString());

    Set<Map.Entry<String, List<String>>> entrySet = treeMap.entrySet();


    for (Map.Entry<String, List<String>> entry : entrySet) {
        List<String> newValueList = new ArrayList<>();

        List<String> stringList = entry.getValue();

        if (stringList.size() > 1) {
            stringList.sort(new Comparator<String>() {
                @Override
                public int compare(String s1, String s2) {

                    if (!s1.contains(".") || !s2.contains(".")) {
                        return s2.compareTo(s1);
                    }

                    String[] split1 = s1.split("\\.");
                    String[] split2 = s2.split("\\.");

                    if (split1.length == 3 && split2.length == 3) {

                        for (int i = 0; i < 3; i++) {
                            try {
                                Integer.parseInt(split1[i]);
                                Integer.parseInt(split2[i]);
                            } catch (Exception e) {
//                                      e.printStackTrace();
                                return s2.compareTo(s1);
                            }


                            if (Integer.parseInt(split2[i]) != Integer.parseInt(split1[i])) {
//                                        return split2[i].compareTo(split1[i]);
                                return Integer.compare(Integer.parseInt(split2[i]), Integer.parseInt(split1[i]));
                            }

                        }

                    } else {
                        return s2.compareTo(s1);
                    }

                    return s2.compareTo(s1);

                }

            });

            List<String> subList = stringList.subList(0, 2);
            newValueList = subList;

        } else {
            // 只有一个

            newValueList = stringList;

        }

        linkedHashMap.put(entry.getKey(), newValueList);

    }

//    System.out.println("linkedHashMap---" + linkedHashMap.toString());


    Set<String> stringKeys = linkedHashMap.keySet();

    String keyListString1 = stringKeys.toString().substring(1);
    String keyListString2 = keyListString1.substring(0, keyListString1.length() - 1);


    StringBuilder stringBuilder2 = new StringBuilder();

    Set<Map.Entry<String, List<String>>> mapEntries = linkedHashMap.entrySet();

    for (Map.Entry<String, List<String>> mapEntry : mapEntries) {

        StringBuilder stringBuilder1 = new StringBuilder();

        String key = mapEntry.getKey();
        List<String> value = mapEntry.getValue();


        for (int i = 0; i < value.size(); i++) {
            String str1;

            if (value.get(i).contains("+")) {
                String[] splitVersion = value.get(i).split("\\+");


                if(splitVersion.length < 2){
                    str1 = "<div style=\"margin-top: 4px; text-align: center\">"
                            + "<a href=\"detail.jsp?packageName=" + key + "&versionCode=" + value.get(i) + "\" target=\"_blank\">"
                            + key + ": " + value.get(i) + "</a>"
                            + "</div>";

                }else if(splitVersion.length == 2){
                    str1 = "<div style=\"margin-top: 4px; text-align: center\">"
                            + "<a href=\"detail.jsp?packageName=" + key + "&versionCode=" + splitVersion[0]
                            + "&versionCode=" + splitVersion[1] + "\" target=\"_blank\">"
                            + key + ": " + value.get(i) + "</a>"
                            + "</div>";

                }else {
                    str1 = "<div style=\"margin-top: 4px; text-align: center\">"
                            + "<a href=\"detail.jsp?packageName=" + key + "&versionCode=" + value.get(i) + "\" target=\"_blank\">"
                            + key + ": " + value.get(i) + "</a>"
                            + "</div>";

                }

            } else {

                str1 = "<div style=\"margin-top: 4px; text-align: center\">"
                        + "<a href=\"detail.jsp?packageName=" + key + "&versionCode=" + value.get(i) + "\" target=\"_blank\">"
                        + key + ": " + value.get(i) + "</a>"
                        + "</div>";

            }


            stringBuilder1.append(str1);

        }


        String str2 = "           <div style=\"\n" +
                "                    background-color: white;\n" +
                "                    float: left; display: block;\n" +
                "                    margin-top: 30px;\n" +
                "                    margin-left: 40px;\n" +
                "                    box-shadow: 0 0 1px #888888;\n" +
                "                    border-radius: 6px\" id=\"" + key + "\">\n" +
                "\n" +
                "                <div style=\"\n" +
                "                    background-color: #CAE1FF;\n" +
                "                    border-top-left-radius: 6px;\n" +
                "                    border-top-right-radius: 6px;\n" +
                "                    width: 260px;\n" +
                "                    height: 25px;\n" +
                "                    padding: 10px;\n" +
                "                      \">\n" +
                "\n" +
                "                  <div style=\"text-align: center;\n" +
                "                        font-weight: bold; color: #333333;\n" +
                "                        overflow: hidden;\n" +
                "                        text-overflow: ellipsis;\n" +
                "                        \">" + key + "\n" +
                "                  </div>\n" +
                "                </div>\n" +
                "\n" +
                "                <div style=\"\n" +
                "                      width: 260px;\n" +
                "                      height: 132px;\n" +
                "                      padding: 10px;\n" +
                "                      margin-top: -17px;\n" +
                "                      display: flex;\n" +
                "                      justify-content: center;\n" +
                "                      align-items: center;\n" +
                "                      flex-direction: column;\n" +
                "                      word-break: break-all;\n" +
                "                      overflow: hidden;\n" +
                "                      \">\n" +
                "                  " + stringBuilder1.toString() + "\n" +
                "                </div>\n" +
                "\n" +
                "              </div>";


        stringBuilder2.append(str2);

    }

%>


<!DOCTYPE html>

<html>

<head>

    <title>packages列表</title>


    <style type="text/css">

        #searchText:hover {

            box-shadow: 0 0 5px #F5F5F5;

        }


        #searchText:focus {

            box-shadow: 0 0 5px #F5F5F5;

        }

    </style>


    <script type="text/javascript">

        window.onload = function () {
            document.getElementById("bodyContainer").style.minHeight = (window.innerHeight + 10).toString() + "px"
            document.getElementById("bodyContainer").style.background = "linear-gradient(#6495ed, #FDF5E6, #6495ed)"

            document.getElementById("divContainerId").style.display = "block";
        };


        function textInput() {
            let keyStrings = "<%=keyListString2%>"
            let stringListKey = keyStrings.split(", ");

            let value = document.getElementById("searchText").value.trim();

            if (value === "") {
                stringListKey.forEach((v, index, array) => {
                        document.getElementById(v).style.display = "block";
                    }
                );

                return;
            }

            stringListKey.forEach((v, index, array) => {

                    if ((v.toLowerCase().indexOf(value.toLowerCase())) !== -1) {
                        document.getElementById(v).style.display = "block";
                    } else {
                        document.getElementById(v).style.display = "none";
                    }

                }
            )

        }


        let TextDivTimeout;

        function installTextShowDiv() {
            if (typeof TextDivTimeout != "undefined") {
                clearTimeout(TextDivTimeout)
            }

            document.getElementById("installTextId").style.color = "#E6E6E6"
            document.getElementById("installContentId").style.display = "block"
        }

        function installContentShowDiv() {
            clearTimeout(TextDivTimeout);
            document.getElementById("installContentId").style.display = "block"
        }

        function installTextDismissDiv() {
            document.getElementById("installTextId").style.color = "#F5F5F5"

            TextDivTimeout = setTimeout(function () {
                document.getElementById("installContentId").style.display = "none"
            }, 300);

        }

        function installContentDismissDiv() {
            document.getElementById("installContentId").style.display = "none"
        }


    </script>

</head>


<body id="bodyContainer">


<div style="margin: 0 auto; width: 1000px; display: none" id="divContainerId">

    <div onmouseover="installTextShowDiv()" onmouseout="installTextDismissDiv()" style="position: absolute;
         margin-left: 880px; margin-top: 38px; cursor: pointer; color: #F5F5F5" id="installTextId">Installing</div>

    <div id="installContentId"

         style=" background: whitesmoke; border-radius: 6px;
                      z-index: 999; position: absolute;

                      display: none; width: fit-content;

                      margin-left: 800px; margin-top: 70px;

                      padding: 10px 10px 13px;" onmouseover="installContentShowDiv()" onmouseout="installContentDismissDiv()">

        <div>dependencies:</div>

        <div style="margin-left: 20px; margin-top: 1px"><font
                color="#6495ed">packageName:</font>
        </div>

        <div style="margin-left: 40px; margin-top: 1px">hosted:</div>

        <div style="margin-left: 60px; margin-top: 1px">name: <font
                color="#6495ed">packageName</font></div>

        <div style="margin-left: 60px; margin-top: 1px">url: <font color="#6495ed">http://192.168.1.118:8081</font>
        </div>

        <div style="margin-left: 40px; margin-top: 1px">version: <font
                color="#6495ed">^0.0.1</font></div>

    </div>


    <div style="padding-top: 25px; padding-bottom: 35px">

            <input type="text" id="searchText" placeholder="Search packages..." oninput="textInput()" autocomplete="off"

                   style="background-color: #F5F5F5;

                     margin-left: 245px;

                     height: 38px;

                     width: 470px;

                     padding-left: 20px;

                     padding-right: 20px;

                     outline: none;

                     border: 0;

                     border-radius: 19px;">

        <div style="display: table; margin-top: 5px">

            <%= stringBuilder2.toString()%>

        </div>

    </div>

</div>

</body>

</html>

