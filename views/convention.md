##biandan3字段约定
---

* 冲突检测webservice
* 下载任务strReadyFilePath
* 下载/迁移任务strhint字段  

插入下载任务的时候, B/S端会存入,如下格式的xml   

1.download节点存放与下载任务相关的信息  
2.rootPath则为C/S共享存储的路径, 通常情况下会是ftp路径, 处理好后的文件需要存放到这里  
3.files节点需要C/S回写, 填写处理后的文件路径信息  

    <iptask>
        <errorMsg></errorMsg>
        <download>
            <!-- 下载任务存放在rootPath下, 一般会给ftp地址 -->
            <rootPath>ftp://shoulu:shoulu@192.168.1.18/downloads</rootPath>
            <files></files>
        </download>
    </iptask>


C/S处理好后需要回写xml, 回写后格式如下: 

1.name文件全名, 包含后缀  
2.path时相对于rootPath的路径   

    <iptask>
        <errorMsg></errorMsg>
        <!-- 下载任务的相关信息 -->
        <download>
            <!-- 下载任务存放在rootPath下, 一般会给ftp地址 -->
            <rootPath>ftp://shoulu:shoulu@192.168.1.18/downloads</rootPath>
            <files>
                <file>
                    <name>xxxx.wmv</name>
                    <!-- 相对rootPath 路径 -->
                    <path>folder1/****.wmv</path>
                </file>
                <file>
                    <name>xxxx.wmv</name>
                    <!-- 相对rootPath 路径 -->
                    <path>folder1/****.wmv</path>
                </file>
                <!-- 多个file继续追加 -->
            </files>   
        </download>
    </iptask>   

