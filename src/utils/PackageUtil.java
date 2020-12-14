package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TreeMap;

public class PackageUtil {

    public static String getUploadTime(String path) {

        File file = new File(path);
        long lastModified = file.lastModified();

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(lastModified);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String formatTime = simpleDateFormat.format(calendar.getTime());

        return formatTime;

    }


    public static void getFilePath(String path, TreeMap<String, List<String>> treeMap) {


        File file = new File(path);
        File[] listFiles = file.listFiles(new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return !name.startsWith(".");
            }
        });


        for (int i = 0; i < listFiles.length; i++) {

            if (listFiles[i].isDirectory()) {

                String packagePath = listFiles[i].getAbsolutePath()
                        .replaceFirst("/Users/kaitian/Desktop/flutter-pub-repository/", "");

//                System.out.println(packagePath);

                String[] splitPathList = packagePath.split("/");


                if (treeMap.containsKey(splitPathList[0])) {
                    // key重复了
                    treeMap.get(splitPathList[0]).add(splitPathList[1]);
                } else {
                    // 新的key
                    List<String> arrayList = new ArrayList<>();
                    treeMap.put(splitPathList[0], arrayList);
                }


                getFilePath(listFiles[i].getAbsolutePath(), treeMap);

            }

        }

    }


    public static String getFileContentText(String filePath, boolean isJsonText) {

        StringBuilder stringBuilder = new StringBuilder();

        BufferedReader bufferedReader = null;

        String line;

        try {

            bufferedReader = new BufferedReader(new FileReader(filePath));

            while ((line = bufferedReader.readLine()) != null) {

                stringBuilder.append(line);

                if (!isJsonText) {
                    stringBuilder.append("\\n");
                }

            }


            bufferedReader.close();

            return stringBuilder.toString();


        } catch (Exception e) {

//            e.printStackTrace();

            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (Exception ex) {
//                    ex.printStackTrace();
                }
            }

        }


        return "";

    }


}
