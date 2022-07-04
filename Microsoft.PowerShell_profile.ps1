Import-Module posh-git
#Import-Module oh-my-posh
oh-my-posh init pwsh | Invoke-Expression
Import-Module -Name Terminal-Icons
#Set-Theme Paradox
oh-my-posh init pwsh --config "C:\Program Files (x86)\oh-my-posh\themes/luka.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -Colors @{ InlinePrediction = '#124373'}
Set-Alias -name die -value git
Set-Alias -name gh -value Get-Help

function wingetupgrade {
    $cmd = ""
    $args = $args | ?{$_ -ne ""}
    foreach ($arg in $args) {
        $cmd += "winget upgrade $arg; "
    }
    Invoke-Expression $cmd
}