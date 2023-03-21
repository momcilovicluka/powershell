Import-Module posh-git
#Import-Module oh-my-posh
#oh-my-posh init pwsh | Invoke-Expression
Import-Module -Name Terminal-Icons
#Set-Theme Paradox
oh-my-posh init pwsh --config "C:\Users\Luka\Documents\PowerShell\luka.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -Colors @{ InlinePrediction = '#124373'}
Set-Alias -name die -value git
Set-Alias -name man -value Get-Help
Set-Alias -name bottom -value btm
Set-Alias -name pusimiga -value pushimiga
Set-Alias -name aria2 -value aria2c
Set-Alias -name aria -value aria2c
Set-Alias -name gitfetchall -value gfa
Set-Alias -name gitpullall -value gpa

function pushimiga { git push }

function gs { git status }

function gf { git fetch --all }

function wingetupgrade {
    $cmd = ""
    $args = $args | ?{$_ -ne ""}
    foreach ($arg in $args) {
        $cmd += "winget upgrade $arg; "
    }
    Invoke-Expression $cmd
}

function clonerepos {
    $cmd = ""
    $args = $args | ?{$_ -ne ""}
    foreach ($arg in $args) {
        $cmd += "gh repo clone $arg; "
	$cmd += "echo '**************************************************';"
    }
    Invoke-Expression $cmd
}

function gfa {
  $currentDirectory = Get-Location
  Get-ChildItem -Directory | ForEach-Object {
    Write-Host "**************************************************"
    Write-Host "->Fetching $($_.Name)"
    Set-Location $_.FullName
    if (Test-Path .git) {
      git fetch
    } else {
      Write-Host "No git repository found in $($_.Name)"
    }
  }
  Set-Location $currentDirectory
}

function gpa {
  $currentDirectory = Get-Location
  Get-ChildItem -Directory | ForEach-Object {
    Write-Host "**************************************************"
    Write-Host "->Pulling $($_.Name)"
    Set-Location $_.FullName
    if (Test-Path .git) {
      git pull
    } else {
      Write-Host "No git repository found in $($_.Name)"
    }
  }
  Set-Location $currentDirectory
}

function mklink ($link, $target) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function time {
    $cmd = ""
    $args = $args | ?{$_ -ne ""}
    foreach ($arg in $args) {
        $cmd += "Measure-Command {start-process $arg -Wait}; "
    }
    Invoke-Expression $cmd
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
