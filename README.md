# QtQuickTemplate

This repository is both a GitHub template repository and a
[Copier](https://copier.readthedocs.io/) template for Qt 6 Quick/QML applications and
libraries.

GitHub creates the repository first so that the generated project retains the
**generated from Dingola/QtQuickTemplate** relationship. Copier then renders all
project-specific names and settings into that repository.

## Create a project

### 1. Create the repository on GitHub

1. Open this repository on GitHub.
2. Select **Use this template** and then **Create a new repository**.
3. Enter the final repository name, for example `QuickDashboard`.
4. Select the owner and visibility and create the repository.

Do not rename the local project directory after cloning unless you also pass an explicit
`-ProjectName` to the initialization script.

### 2. Install local prerequisites

Install the following tools:

- Git
- A stable Python release supported by Copier
- [pipx](https://pipx.pypa.io/)
- Copier 9 or newer

Pre-release Python versions are not recommended because native dependencies may not be
binary-compatible with early alpha or beta releases. Check the installed Python
versions first:

```powershell
py -0p
```

The following example uses stable Python 3.14. Replace `3.14` with another installed
stable version if necessary. Run each command separately:

```powershell
py -3.14 -m pip install --upgrade pip
```

```powershell
py -3.14 -m pip install --user pipx
```

```powershell
py -3.14 -m pipx ensurepath
```

Open a new PowerShell window after `ensurepath`, then install Copier:

```powershell
py -3.14 -m pipx install --python 3.14 copier
```

Verify the installation:

```powershell
pipx --version
```

```powershell
copier --version
```

If `py` is unavailable, install a stable 64-bit Python release from
[python.org](https://www.python.org/downloads/windows/) and enable the option that adds
Python to `PATH`.

### 3. Clone and initialize the repository

```powershell
git clone https://github.com/<OWNER>/QuickDashboard.git
```

```powershell
cd QuickDashboard
```

```powershell
.\initialize.cmd
```

The script uses the repository directory name as the CMake project name. It validates
the Git working tree, runs Copier against `gh:Dingola/QtQuickTemplate`, and removes
the bootstrap-only files after successful generation.

The repository directory name must be a valid CMake target name: it must start with a
letter and contain only letters, numbers, and underscores. A repository name such as
`QuickDashboard` works without additional arguments. A name such as
`quick-dashboard` does not, because hyphens are not supported by the generated CMake
option names and workflows.

To test an unreleased template revision:

```powershell
.\initialize.cmd -VcsRef HEAD
```

Use released template versions for normal projects. `HEAD` is intended for template
development and testing.

### 4. Answer the Copier questions

Copier asks for these values:

| Question | Purpose | Example |
| --- | --- | --- |
| CMake project and target name | CMake project, target, and test-target prefix | `QuickDashboard` |
| Human-readable name | Display name shown by Qt | `Quick Dashboard` |
| Docker name | Lowercase Docker image and container prefix | `quick-dashboard` |
| Macro prefix | Uppercase C and C++ export-macro prefix | `QUICK_DASHBOARD` |
| CMake target type | Executable, shared library, or static library | `executable` |
| Organization name | `QCoreApplication` organization | `Dingola` |
| Organization domain | `QCoreApplication` domain | `AdrianHelbig.de` |
| Repository owner | GitHub user or organization used in README links | `Dingola` |
| Project description | Short generated-project description | `A Qt Quick dashboard application.` |

For applications select `executable`. For libraries select `dynamic_library` or
`static_library`.

After successful generation, the bootstrap files are removed and
`.copier-answers.yml` is created. Keep this file under version control; Copier requires
it for future template updates. Do not edit it manually.

### 5. Review and commit the generated project

```powershell
git status
```

```powershell
git diff
```

```powershell
git add .
```

```powershell
git commit -m "Initialize project from QtQuickTemplate"
```

```powershell
git push
```

The GitHub template relationship remains intact because the repository was originally
created with **Use this template**.

### 6. Configure repository services

After the first push:

1. Open the repository's **Actions** tab and confirm that the generated workflows are enabled.
2. Add the repository to Codecov if coverage uploads are required.
3. Add `CODECOV_TOKEN` under **Settings > Secrets and variables > Actions**.
4. Review repository visibility, branch protection, topics, and description.

The generated README contains the detailed Codecov setup.

## Generated-project releases

Every generated project contains `.github/workflows/release.yml`. Pushing a semantic
version tag such as `v1.0.0` starts one workflow that:

1. validates the tag and creates a draft GitHub Release;
2. tests the tagged revision;
3. builds native Windows, Linux, and macOS packages in parallel;
4. uploads packages directly to the draft as GitHub Release Assets;
5. creates `SHA256SUMS.txt`; and
6. publishes the release only after every required platform succeeds.

The workflow does not use `actions/upload-artifact`, so release binaries do not consume
the GitHub Actions artifact-storage quota. A failed platform build leaves the release
as a draft for inspection and reruns replace assets with `--clobber`.

Applications produce a Windows portable ZIP and NSIS installer, a Linux AppImage, and
a deployed macOS application ZIP. Static and shared libraries produce platform SDK
archives containing the installed headers, libraries, and CMake package files.

The version follows this single path:

```text
Git tag v1.2.3
    -> MAIN_PROJECT_VERSION=1.2.3
    -> project(VERSION 1.2.3)
    -> Config.h and CMake package metadata
    -> versioned release asset names
```

Template-version tags and generated-project release tags belong to different
repositories. This template uses tags such as `1.0.0` for Copier updates. Generated
projects use tags such as `v1.0.0` for application or library releases.

## Troubleshooting initialization

### PowerShell blocks scripts

Use the command wrapper:

```powershell
.\initialize.cmd
```

It applies `ExecutionPolicy Bypass` only to the child PowerShell process and does not
change the persistent user or machine policy. If the wrapper is unavailable, use:

```powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File ".\initialize.ps1"
```

### `pipx` or `copier` is not found

Reapply the user `PATH` configuration and then open a new terminal:

```powershell
py -3.14 -m pipx ensurepath
```

For the current PowerShell session, the pipx binary directory can be added immediately:

```powershell
$env:Path += ";" + (py -3.14 -m pipx environment --value PIPX_BIN_DIR)
```

Then verify:

```powershell
copier --version
```

### Initialization reports a dirty working tree

The initialization intentionally refuses to overwrite uncommitted work. A repository
created and freshly cloned through **Use this template** should initially be clean:

```powershell
git status
```

Commit or intentionally discard unrelated changes before running the initializer
again.

### Initialization fails while Copier is running

The bootstrap files are retained when Copier fails. Correct the reported problem and
run `.\initialize.cmd` again. Do not manually remove `template/` or `copier.yml`.

## Update a generated project

Generated projects contain `.copier-answers.yml`. Do not edit that file manually.
Start from a clean Git working tree:

```powershell
git status
```

```powershell
copier update
```

Review all changes and resolve possible conflicts before committing:

```powershell
git diff
```

```powershell
git add .
```

```powershell
git commit -m "Update project from QtQuickTemplate"
```

```powershell
git push
```

## Template maintenance

The repository root contains the bootstrap:

```text
.
|-- .github/
|   `-- workflows/
|       `-- validate_template.yml
|-- copier.yml
|-- initialize.cmd
|-- initialize.ps1
|-- README.md
`-- template/
    |-- .github/
    |   |-- release-config.env.jinja
    |   `-- workflows/
    |       `-- release.yml
    |-- Configs/
    |   `-- AppIcon.svg
    |-- README.md.jinja
    |-- Dockerfile.jinja
    |-- CMakeLists.txt.jinja
    |-- QML_Project/
    |-- QML_Project_Tests/
    `-- Scripts/
```

All files that must appear in generated projects belong under `template/`. Files whose
contents contain Copier expressions use the `.jinja` suffix. Copier removes this suffix
when rendering.

Generated release settings are stored in `template/.github/release-config.env.jinja`.
The rendered `.github/release-config.env` is consumed by `release.yml` and contains the
project name, display name, target type, and publisher.

After changing the template:

1. Generate a test project into a separate directory.
2. Configure, build, and test the generated project.
3. Review and commit the template changes.
4. Push the default branch and wait for `Validate Copier Template`.
5. Create and push a new PEP 440-compatible template tag.

Example local generation:

```powershell
copier copy . ..\QtQuickTemplateSmokeTest
```

Example commit and template release:

```powershell
git status
```

```powershell
git add .
```

```powershell
git commit -m "Describe the template change"
```

```powershell
git push origin main
```

```powershell
git tag -a 1.0.0 -m "Release template 1.0.0"
```

```powershell
git push origin 1.0.0
```

Copier selects released tags for normal generation and uses them to calculate future
project updates.
