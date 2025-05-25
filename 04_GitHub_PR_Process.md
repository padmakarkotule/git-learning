# GitHub PR Process

   #### **Your merge goal**
   | Your Goal                              | Commands to Run                                    |
   | -------------------------------------- | -------------------------------------------------- |
   | Merge `Feature` → `dev` (promote to prod) | `git checkout dev` → `git merge feature` → `git push` |
   | Merge `dev` → `main` (promote to prod) | `git checkout main` → `git merge dev` → `git push` |
   | # You may use this for first time, if needed.
   | Merge `main` → `dev` (sync updates)    | `git checkout dev` → `git merge main` → `git push` |





   3. **Push Changes and Tags**:
      ```bash
      git push origin feature/awesome-feature
      git push origin v1.0  # Push the tag to the remote
      `
- **`git log`**: View the history of commits and tags on the current branch.
