/********************** add nuget push menu to vs Tool ***********************/
1、open vs -> Tool -> External Tools
2、Add menu
A、Title:	 	e.g. NugetPackagePush
B、Command: 	the .bat path
C、Params: 	 $(ProjectDir)$(ProjectFileName) $(TargetName)
	Tips: Paramss should has an empty string befor the $tag

/********************** add nuget push menu to vs project right click menu ***********************/
1、open vs -> Tool -> Customize
2、select Command tab
3、focus on Context menu: Project and Solution Context Menus | Project
4、click Add Command
5、在左边选择【Tools】,右边的Command,，刚才增加后，那个外部工具是第第N项就选择external Command N
