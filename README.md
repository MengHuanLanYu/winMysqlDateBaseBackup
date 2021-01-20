# windows中mysql数据库备份脚本

## 启动方式
### cmd方式调用
- 第一种：win + r 输入 cmd 命令，在命令行中输入 backup.bat 数据库IP 用户名 密码 数据库名称
- 第二种：修改start-backup.bat中第22行，*call backup.bat 数据库IP 用户名 密码 数据库名称*，然后双击启动。
### windows定时任务
1. Windows键+R，调出此窗口，输入compmgmt.msc
2. 找到任务计划程序，点击右侧创建基本任务
3. 在弹出的对话框中输入基本的信息如名称、描述、触发时间，在第三步选择启动程序，选中修改好的start-backup.bat文件点击完成即可。*这里可能会出现路径问题，具体原因具体对待*

## 运行结果

<img src="https://github.com/MengHuanLanYu/winMysqlDateBaseBackup/运行结果.png" />
