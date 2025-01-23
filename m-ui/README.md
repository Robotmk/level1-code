# Module Desktop Testing 

## env creation / VS Code

- Open a PS in the m-ui dir, create environment: 
    - `rcc-space -Robotpath environment`
- open VS Code for the directories: 
    - m-ui (left)
    - module-desktop-testing (right)

## Chapter-Manager 

Open a Git Bash in "module-desktop-testing"

### insert new chapter

`<newindex>` to add the new chapter after a specific one instead of the end.

```
chapter-manager.exe insert <chaptername>
chapter-manager.exe insert -i <newindex> <chaptername> 
```

Do not forget to checkout the new branch!

`git checkout <chaptername>`

### Commit

Change/add files now and commit work (also adds all files): 

`chapter-manager.exe commit -m "foo"`

If the commit happens not in the latest branch, cm tries to cherry-pick the change to all following branches.  
If the same line was changed in a later branche, a CONFLICT will happen. In that case, open the diff file in VS code and decide whether this change shoudl be propagated or if the change of the current branch should be taken.  
To resolve the conflict, use `chapter-manager.exe commit --continue`

### Index

On Main branch, use `chapter-manager index`.  
This updates the README file with the diff table and creates a folder for each branch below of chapter. 