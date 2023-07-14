# How to understand anything GitHub Edition.
>In this guide, the purpose is to inform the common user how to sign in to a Microsoft **Visual Studio Code Repository** using **GitHub** as a database.
______

### _Steps; in order of maximized efficiency and ease of access to the user:_

1. To get started in accessing the project using Microsoft Visual Studio Code (VSCode) and GitHub, first you must create a GitHub account. A list of steps can be found at: [GitHub Account Tutorial](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account)
2. In the GitHub account, users are encouraged to set up two-step verification to access the project or become a member of the organization. A list of steps can be found at: [Two-Step Tutorial](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa)
3. Once a github account is created, users are then encouraged to install “Git,” a program essential to the function of VSCode in order to access the root directory of the project. A link to access Git can be found at: [Git - Downloading Package (git-scm.com)](https://git-scm.com/download/win)
   ![Alt text](vscode3.png)
4. When at the link, the first step is to press the “Click here to download” button. Once this is done, the link will transfer you to a GitHub page that will prompt a 2fa verification for GitHub. If 2 step verification was set up correctly earlier, this should be a simple straightforward verification to proceed.
5. Then, once the download has started, it is best and strongly recommended to closely follow the next steps for installation. Select all the default options and proceed until the first window opens with checkbox selection for included features. The following is what should be selected:
![Alt text](vscode5.png)
6. Following this step, leave the next step default and then select the following option as shown:
![Alt text](vscode6.png)
7. Make sure to name the default branch “main” to ensure compatibility with all repositories in the project.
8. Then, at the next step, make sure to select the 3rd option to allow for Git to work with Unix tools as can be shown by the following:
![Alt text](vscode7.png)
9. Then, before proceeding to the next step, it is highly recommended that the user installs OpenSSH. To do this, the user should go into the Microsoft Search Bar, and search “Optional Features,” to bring up a settings page. Then, press on optional features and “View Features” and search for OpenSSH and get it. If it is not present there, then that means your device is already installed with OpenSSH and you may move on to the next step:
![Alt text](vscode8.png)
10. Then, return back to the Git installer. There, move on to the next step and select “Use external OpenSSH” as shown by the following:
![Alt text](vscode9.png)
11. Then, on the next step, select the 2nd option as shown by the following:
![Alt text](vscode10.png)
12. On the next step, select the 2nd option as shown by the following:
![Alt text](vscode11.png)
13. On the next step, keep the first open selected, as to avoid using the default Windows terminal:
![Alt text](vscode12.png)
14. Then, moving on to the next step, select the 2nd option labeled “Rebase” as shown:
![Alt text](vscode13.png)
15. On the next step, make sure to leave the first option selected and allow the Git Credential Manager to function as shown:
![Alt text](vscode14.png)
16. And then, on the following step, select both options as shown:
![Alt text](vscode15.png)
17. Similarly, on the next step, select both options once again as shown:
![Alt text](vscode16.png)
18. Once this is done, hit install and allow the program to automatically proceed installation. Once installation is complete, open Git and ensure that no errors are present. If not, it is recommended to close it.
19. Now, you can move on to installing VSCode. Do so by visiting the following link: [VSCode Installation](https://code.visualstudio.com/download) and select the install for whichever operating system you have. The download should begin automatically.
20. Open the install launcher and at the first screen, accept the agreement.
21. At the next step, leave the installation path default and move on.
22. And then, at the following step, leave the start menu folder name default.
23. At the next step where it prompts you to select additional tasks, select all of the available tasks and move on as shown:
![Alt text](Vscode1.png)
24. Then, complete the install on the next step and wait for VSCode to finish installing.
25. Before proceeding, it is imperative to install the Windows Terminal as the normal Command Prompt is a highly outdated program and is not recommended to be used. To download Windows Terminal, head to the Microsoft Store and search up “Terminal” and download it as shown:
![Alt text](vscode4.png)
26. Now, when Windows Terminal is downloaded, proceed to VSCode and now, since Git is installed, you can open the project in VSCode. However, before then, you must log in to GitHub on VSCode and also turn on some settings. To start, navigate to the bottom left of the screen and press on the account icon that looks like a silhouette of a person. Then, press on “Turn on Settings Sync.” Afterwards, you will be redirected with an option to log in to your GitHub. Log in to GitHub to continue with opening the project. Then, in the same menu, press on the setting that says “Settings Sync” as shown:
![Alt text](vscode18.png)
27. After, when the settings sync screen comes up, go ahead and select all of the options available on the menu and then proceed to press the Sign In button in order to sign in to GitHub. After, complete the sign in as shown:
![Alt text](vscode19.png)
28. When sign in is complete, authorize VSCode to Github as shown:
![Alt text](vscode20.png)
29. Once this is complete, proceed to VSCode again and then at Source Control, press on the Clone Repository button to access the repository of an existing project as shown:
![Alt text](vscode22.png)
30. Reliant upon the fact that the user is already a part of the organization, pressing the Clone Repository button will allow the user to search for the repository that they need. When the menu comes up, press on the “Clone from GitHub” option that pops up first as shown:
![Alt text](vscode23.png)
31. After the option is pressed, there will open a new screen in GitHub that will request the user to authorize GitHub to VSCode as shown below:
![Alt text](vscode24.png)
32. Then, once the option is pressed, there will appear many options in the same menu of various repositories from your organizations. Specifically for this case, the user should look for the option ending in “devcontainers-features” as shown:
![Alt text](vscode26.png)
33. Then, once the repository is selected, there will be a file explorer prompt that pops up that will ask the user to select a folder to put the repository files in. Ideally, it is best that the user goes to the following file path: Local Disk (Main Drive) -> Users -> (User) -> (Create new folder called “source”) -> (Create new folder called “repos”) and then place the repositories in the repos folder as shown:
![Alt text](vscode27.png)
34. Then, once the folder is selected, go back to VSCode and authorize the authors of the files to make changes to the files that will reflect on your end, as the repository is a shared folder. The screen should look as shown:
![Alt text](vscode28.png)
35. Once you authorize the files, you are now going to be able to make changes and edits to the files. However, before doing so, an important feature to note is once again in Source Control, where users will be able to commit changes to the cloud once they are finalized locally. The feature should look as shown:
![Alt text](vscode29.png)
36. However, to use this feature, one must first confirm their Git username and email to VSCode, which is a separate process from signing in to GitHub that was done earlier. An error message like this should pop up:
![Alt text](vscode31.png)
37. To fix this, the user should find the Explorer option in VSCode, located at the top left of the window and press on it to travel to the opened repository as shown:
![Alt text](vscode30.png)
38. Then, to fix the error, press Ctrl+Shift+P in VSCode, which prompts the same menu shown before. However, instead of pressing Git:Clone, the user should press Terminal: Create New Terminal. In the terminal that pops up, type: “ .”
39. **At this point, the user should be able to navigate and use repositories in VSCode off of GitHub.**
---