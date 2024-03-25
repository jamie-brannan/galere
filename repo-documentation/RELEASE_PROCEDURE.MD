# Release Procedure

At all times there should be a `develop` branch that points to `main` with it's own merge request, named with `<version number> Release` next to it.

It's **description** should be filled with the release github pull request template. Then any other releavant specifications to that release written out.

Releasing requires:

1. Create this pull request (PR) of `develop` pointing to `main` if this has not already been done
2. **Next**, `git pull` the `develop` branch `origin` to ensure the commits of the corresponding version number release milestone issue.
3. **Update** the build number in Xcode (use `bin/generate_build_number.sh`)
4. **Update** the version number in Xcode (⚠ Watch out for differences between "marketing" version and current version numbers)
5. **Update** the `README.md` with the specified version number
6. Ensure all unit tests run locally. If more than a simple quick fix is required, make a new issue.
7. Manually test the functionality of the application build on a real device, that it meets the expected release requirements found in the PR description and milestone issue inventory. Create new issues as needed
8. Make only one commit of minor changes for the release as needed (update of `README.md` included)
9. Ensure piplines and all reviews pass; and approvals have been granted on PR on github
10. From cleared green-lit PR on github, create a merge commit with the name of the release (as cited above)
11. [Git tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging) the hash of this merge commit of the release with the specified release number

Following the release, kindly rebase create a new `develop` branch pull with the next specified release version number or simply `Release`