#Connect-MgGraph -Scopes "User.ReadWrite.All"

Import-Csv -Path "./users.csv" | ForEach-Object {
    $user = @{
        DisplayName = $_.DisplayName
        MailNickname = $_.MailNickname
        UserPrincipalName = "$($_.MailNickname)@julio-devlab.onmicrosoft.com"
        AccountEnabled = $true
        PasswordProfile = @{
            ForceChangePasswordNextSignIn = $true
            Password = "P@ssw0rd123!"
        }
    }

    try {
        New-MgUser -BodyParameter $user
        Write-Host "Utilisateur créé : $($_.DisplayName)" -ForegroundColor Green
    }
    catch {
        Write-Host "Erreur lors de la création de : $($_.DisplayName)" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

