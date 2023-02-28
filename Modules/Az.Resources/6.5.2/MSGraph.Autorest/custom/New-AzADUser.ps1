
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Adds new entity to users
.Description
Adds new entity to users
.Notes

.Link
https://learn.microsoft.com/powershell/module/az.resources/new-azaduser
#>
function New-AzADUser {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphUser])]
[CmdletBinding(DefaultParameterSetName='WithPassword', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # A freeform text entry field for the user to describe themselves.
    # Returned only on $select.
    ${AboutMe},

    [Parameter()]
    [System.Boolean]
    [Alias('EnableAccount')]
    # true for enabling the account; otherwise, false.
    ${AccountEnabled},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Sets the age group of the user.
    # Allowed values: null, minor, notAdult and adult.
    # Refer to the legal age group property definitions for further information.
    # Supports $filter (eq, ne, NOT, and in).
    ${AgeGroup},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # The birthday of the user.
    # The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time.
    # For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z Returned only on $select.
    ${Birthday},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The city in which the user is located.
    # Maximum length is 128 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${City},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The company name which the user is associated.
    # This property can be useful for describing the company that an external user comes from.
    # The maximum length of the company name is 64 characters.Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${CompanyName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Sets whether consent has been obtained for minors.
    # Allowed values: null, granted, denied and notRequired.
    # Refer to the legal age group property definitions for further information.
    # Supports $filter (eq, ne, NOT, and in).
    ${ConsentProvidedForMinor},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The country/region in which the user is located; for example, US or UK.
    # Maximum length is 128 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${Country},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # .
    ${DeletedDateTime},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The name for the department in which the user works.
    # Maximum length is 64 characters.Supports $filter (eq, ne, NOT , ge, le, and in operators).
    ${Department},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Int32]
    # The limit on the maximum number of devices that the user is permitted to enroll.
    # Allowed values are 5 or 1000.
    ${DeviceEnrollmentLimit},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The name displayed in the address book for the user.
    # This value is usually the combination of the user's first name, middle initial, and last name.
    # This property is required when a user is created and it cannot be cleared during updates.
    # Maximum length is 256 characters.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith), $orderBy, and $search.
    ${DisplayName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # The date and time when the user was hired or will start work in case of a future hire.
    # Supports $filter (eq, ne, NOT , ge, le, in).
    ${EmployeeHireDate},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The employee identifier assigned to the user by the organization.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith).
    ${EmployeeId},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Captures enterprise worker type.
    # For example, Employee, Contractor, Consultant, or Vendor.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith).
    ${EmployeeType},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # For an external user invited to the tenant using the invitation API, this property represents the invited user's invitation status.
    # For invited users, the state can be PendingAcceptance or Accepted, or null for all other users.
    # Supports $filter (eq, ne, NOT , in).
    ${ExternalUserState},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # Shows the timestamp for the latest change to the externalUserState property.
    # Supports $filter (eq, ne, NOT , in).
    ${ExternalUserStateChangeDateTime},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The fax number of the user.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith).
    ${FaxNumber},
  
    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The given name (first name) of the user.
    # Maximum length is 64 characters.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith).
    ${GivenName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.DateTime]
    # The hire date of the user.
    # The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time.
    # For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.
    # Returned only on $select.
    # Note: This property is specific to SharePoint Online.
    # We recommend using the native employeeHireDate property to set and update hire date values using Microsoft Graph APIs.
    ${HireDate},
  
    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # A list for the user to describe their interests.
    # Returned only on $select.
    ${Interest},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Do not use – reserved for future use.
    ${IsResourceAccount},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The user's job title.
    # Maximum length is 128 characters.
    # Supports $filter (eq, ne, NOT , ge, le, in, startsWith).
    ${JobTitle},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The SMTP address for the user, for example, admin@contoso.com.
    # Changes to this property will also update the user's proxyAddresses collection to include the value as an SMTP address.
    # While this property can contain accent characters, using them can cause access issues with other Microsoft applications for the user.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith, endsWith).
    ${Mail},
  
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The mail alias for the user.
    # This property must be specified when a user is created.
    # Maximum length is 64 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${MailNickname},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The primary cellular telephone number for the user.
    # Read-only for users synced from on-premises directory.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${MobilePhone},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The URL for the user's personal site.
    # Returned only on $select.
    ${MySite},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The office location in the user's place of business.
    # Maximum length is 128 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${OfficeLocation},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    [Alias("OnPremisesImmutableId")]
    # This property is used to associate an on-premises Active Directory user account to their Azure AD user object.
    # This property must be specified when creating a new user account in the Graph if you are using a federated domain for the user's userPrincipalName (UPN) property.
    # NOTE: The $ and _ characters cannot be used when specifying this property.
    # Returned only on $select.
    # Supports $filter (eq, ne, NOT, ge, le, in)..
    ${ImmutableId},
  
    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # A list of additional email addresses for the user; for example: ['bob@contoso.com', 'Robert@fabrikam.com'].NOTE: While this property can contain accent characters, they can cause access issues to first-party applications for the user.Supports $filter (eq, NOT, ge, le, in, startsWith).
    ${OtherMail},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # Specifies password policies for the user.
    # This value is an enumeration with one possible value being DisableStrongPassword, which allows weaker passwords than the default policy to be specified.
    # DisablePasswordExpiration can also be specified.
    # The two may be specified together; for example: DisablePasswordExpiration, DisableStrongPassword.Supports $filter (ne, NOT).
    ${PasswordPolicy},

    [Parameter(ParameterSetName="WithPasswordProfile", Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.IMicrosoftGraphPasswordProfile]
    # passwordProfile
    # To construct, see NOTES section for PASSWORDPROFILE properties and create a hash table.
    ${PasswordProfile},
  
    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The postal code for the user's postal address.
    # The postal code is specific to the user's country/region.
    # In the United States of America, this attribute contains the ZIP code.
    # Maximum length is 40 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${PostalCode},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The preferred language for the user.
    # Should follow ISO 639-1 Code; for example en-US.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${PreferredLanguage},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The preferred name for the user.
    # Returned only on $select.
    ${PreferredName},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # A list for the user to enumerate their responsibilities.
    # Returned only on $select.
    ${Responsibility},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # A list for the user to enumerate the schools they have attended.
    # Returned only on $select.
    ${School},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # true if the Outlook global address list should contain this user, otherwise false.
    # If not set, this will be treated as true.
    # For users invited through the invitation manager, this property will be set to false.
    # Supports $filter (eq, ne, NOT, in).
    ${ShowInAddressList},

    [Parameter()]
    [AllowEmptyCollection()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String[]]
    # A list for the user to enumerate their skills.
    # Returned only on $select.
    ${Skill},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The state or province in the user's address.
    # Maximum length is 128 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${State},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The street address of the user's place of business.
    # Maximum length is 1024 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${StreetAddress},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The user's surname (family name or last name).
    # Maximum length is 64 characters.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${Surname},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # A two letter country code (ISO standard 3166).
    # Required for users that will be assigned licenses due to legal requirement to check for availability of services in countries.
    # Examples include: US, JP, and GB.
    # Not nullable.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith).
    ${UsageLocation},
  
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # The user principal name (UPN) of the user.
    # The UPN is an Internet-style login name for the user based on the Internet standard RFC 822.
    # By convention, this should map to the user's email name.
    # The general format is alias@domain, where domain must be present in the tenant's collection of verified domains.
    # This property is required when a user is created.
    # The verified domains for the tenant can be accessed from the verifiedDomains property of organization.NOTE: While this property can contain accent characters, they can cause access issues to first-party applications for the user.
    # Supports $filter (eq, ne, NOT, ge, le, in, startsWith, endsWith) and $orderBy.
    ${UserPrincipalName},
  
    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Body')]
    [System.String]
    # A string value that can be used to classify user types in your directory, such as Member and Guest.
    # Supports $filter (eq, ne, NOT, in,).
    ${UserType},
  
    [Parameter(ParameterSetName="WithPassword", Mandatory)]
    [SecureString]
    # Password for the user. It must meet the tenant's password complexity requirements. It is recommended to set a strong password.
    ${Password},

    [Parameter(ParameterSetName="WithPassword")]
    [System.Management.Automation.SwitchParameter]
    # It must be specified if the user must change the password on the next successful login (true). Default behavior is (false) to not change the password on the next successful login.
    ${ForceChangePasswordNextLogin},
  
    [Parameter()]
    [Alias("AzContext", "AzureRmContext", "AzureCredential")]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},
  
    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},
  
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},
  
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},
  
    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},
  
    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},
  
    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
  )
  
  process {
    if ($PSBoundParameters['ImmutableId']) {
      $PSBoundParameters['OnPremisesImmutableId'] = $PSBoundParameters['ImmutableId']
      $null = $PSBoundParameters.Remove('ImmutableId')
    }

    if ($PSBoundParameters.ContainsKey('Password')) {
      $passwordProfile = [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordProfile]::New()
      $passwordProfile.ForceChangePasswordNextSignIn = $ForceChangePasswordNextLogin
      $passwordProfile.Password = . "$PSScriptRoot/../utils/Unprotect-SecureString.ps1" $PSBoundParameters['Password']
      $null = $PSBoundParameters.Remove('Password')
      $null = $PSBoundParameters.Remove('ForceChangePasswordNextLogin')
      $PSBoundParameters['AccountEnabled'] = $true
      $PSBoundParameters['PasswordProfile'] = $passwordProfile
    }

    Az.MSGraph.internal\New-AzADUser @PSBoundParameters
  }
}
# SIG # Begin signature block
# MIInrQYJKoZIhvcNAQcCoIInnjCCJ5oCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDBr+ggY/gyWaoI
# 97XTngDuCFdqrDxJ7dpO25jzRnQCyqCCDYEwggX/MIID56ADAgECAhMzAAACzI61
# lqa90clOAAAAAALMMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjIwNTEyMjA0NjAxWhcNMjMwNTExMjA0NjAxWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCiTbHs68bADvNud97NzcdP0zh0mRr4VpDv68KobjQFybVAuVgiINf9aG2zQtWK
# No6+2X2Ix65KGcBXuZyEi0oBUAAGnIe5O5q/Y0Ij0WwDyMWaVad2Te4r1Eic3HWH
# UfiiNjF0ETHKg3qa7DCyUqwsR9q5SaXuHlYCwM+m59Nl3jKnYnKLLfzhl13wImV9
# DF8N76ANkRyK6BYoc9I6hHF2MCTQYWbQ4fXgzKhgzj4zeabWgfu+ZJCiFLkogvc0
# RVb0x3DtyxMbl/3e45Eu+sn/x6EVwbJZVvtQYcmdGF1yAYht+JnNmWwAxL8MgHMz
# xEcoY1Q1JtstiY3+u3ulGMvhAgMBAAGjggF+MIIBejAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUiLhHjTKWzIqVIp+sM2rOHH11rfQw
# UAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1
# ZXJ0byBSaWNvMRYwFAYDVQQFEw0yMzAwMTIrNDcwNTI5MB8GA1UdIwQYMBaAFEhu
# ZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNpZ1BDQTIwMTFfMjAxMS0w
# Ny0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUFBzAChkVodHRwOi8vd3d3
# Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0NvZFNpZ1BDQTIwMTFfMjAx
# MS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEAeA8D
# sOAHS53MTIHYu8bbXrO6yQtRD6JfyMWeXaLu3Nc8PDnFc1efYq/F3MGx/aiwNbcs
# J2MU7BKNWTP5JQVBA2GNIeR3mScXqnOsv1XqXPvZeISDVWLaBQzceItdIwgo6B13
# vxlkkSYMvB0Dr3Yw7/W9U4Wk5K/RDOnIGvmKqKi3AwyxlV1mpefy729FKaWT7edB
# d3I4+hldMY8sdfDPjWRtJzjMjXZs41OUOwtHccPazjjC7KndzvZHx/0VWL8n0NT/
# 404vftnXKifMZkS4p2sB3oK+6kCcsyWsgS/3eYGw1Fe4MOnin1RhgrW1rHPODJTG
# AUOmW4wc3Q6KKr2zve7sMDZe9tfylonPwhk971rX8qGw6LkrGFv31IJeJSe/aUbG
# dUDPkbrABbVvPElgoj5eP3REqx5jdfkQw7tOdWkhn0jDUh2uQen9Atj3RkJyHuR0
# GUsJVMWFJdkIO/gFwzoOGlHNsmxvpANV86/1qgb1oZXdrURpzJp53MsDaBY/pxOc
# J0Cvg6uWs3kQWgKk5aBzvsX95BzdItHTpVMtVPW4q41XEvbFmUP1n6oL5rdNdrTM
# j/HXMRk1KCksax1Vxo3qv+13cCsZAaQNaIAvt5LvkshZkDZIP//0Hnq7NnWeYR3z
# 4oFiw9N2n3bb9baQWuWPswG0Dq9YT9kb+Cs4qIIwggd6MIIFYqADAgECAgphDpDS
# AAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDlaFw0yNjA3MDgyMTA5MDla
# MH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMT
# H01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS68rZYIZ9CGypr6VpQqrgG
# OBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15ZId+lGAkbK+eSZzpaF7S
# 35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+erCFDPs0S3XdjELgN1q2jz
# y23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVceaVJKecNvqATd76UPe/7
# 4ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGMXeiJT4Qa8qEvWeSQOy2u
# M1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/U7qcD60ZI4TL9LoDho33
# X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwjp6lm7GEfauEoSZ1fiOIl
# XdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwCgl/bwBWzvRvUVUvnOaEP
# 6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1JMKerjt/sW5+v/N2wZuLB
# l4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3coKPHtbcMojyyPQDdPweGF
# RInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfenk70lrC8RqBsmNLg1oiM
# CwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFEhuZOVQ
# BdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1Ud
# DwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFHItOgIxkEO5FAVO
# 4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwubWljcm9zb2Z0
# LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAChkJodHRwOi8vd3d3Lm1p
# Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4DMIGDMD8GCCsGAQUFBwIB
# FjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2RvY3MvcHJpbWFyeWNw
# cy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AcABvAGwAaQBjAHkA
# XwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIBAGfyhqWY
# 4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjDctFtg/6+P+gKyju/R6mj
# 82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw/WvjPgcuKZvmPRul1LUd
# d5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkFDJvtaPpoLpWgKj8qa1hJ
# Yx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3zDq+ZKJeYTQ49C/IIidYf
# wzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEnGn+x9Cf43iw6IGmYslmJ
# aG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1Fp3blQCplo8NdUmKGwx1j
# NpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0QaxdR8UvmFhtfDcxhsEvt9B
# xw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AApxbGbpT9Fdx41xtKiop96
# eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//WsyNodeav+vyL6wuA6mk7
# r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqxP/uozKRdwaGIm1dxVk5I
# RcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIZgjCCGX4CAQEwgZUwfjELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9z
# b2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAsyOtZamvdHJTgAAAAACzDAN
# BglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgccRPDERl
# Tc4kj22hrQtPzTPYL2HzmE57yim62RjDvmgwQgYKKwYBBAGCNwIBDDE0MDKgFIAS
# AE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbTAN
# BgkqhkiG9w0BAQEFAASCAQBbAM20AqCQ5TdwBLa5l7bT2GyFePD/E9zkb1ANsYy+
# sIsTAPskDP4IysboOa8zgfel1gsZSL+Pb+n15jxgin1Obfr4HkKuME3TgiCR9BP0
# al8oXIF55/5rGTqcGvF4Rqj9JpYIgC4ge/CiBHAyZUVKdOJ2QqFV9yVyR7GEf5rf
# s0Z837ydXZdrtPUbHkV/bbw2N+RDrUKl433YhUmiFZP7qrsdWcniymfUgOLSDWCW
# vm7V59B6M0Q+lIsV8C/7WJlfmCDhqizciPuPf5JuCzKogEcxUErczIbej39+LG8X
# v7NAYreeLUeDwuCGjMbWeFVf3E1kyV6RoXwKtnYCAbm5oYIXDDCCFwgGCisGAQQB
# gjcDAwExghb4MIIW9AYJKoZIhvcNAQcCoIIW5TCCFuECAQMxDzANBglghkgBZQME
# AgEFADCCAVUGCyqGSIb3DQEJEAEEoIIBRASCAUAwggE8AgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEINIZk6kKQ10drhF0AFgpg+830JNGRPY7eUrJkKFI
# R08FAgZjxxY/uN0YEzIwMjMwMjAzMTA0NTI2LjU2M1owBIACAfSggdSkgdEwgc4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1p
# Y3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjo2MEJDLUUzODMtMjYzNTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCEV8wggcQMIIE+KADAgECAhMzAAABpllFgzlNnutLAAEA
# AAGmMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTIyMDMwMjE4NTEyMVoXDTIzMDUxMTE4NTEyMVowgc4xCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVy
# YXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo2MEJD
# LUUzODMtMjYzNTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vydmlj
# ZTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANmYv3tSI+fJ/NQJnjz7
# JvCnc+Xm0rKoe9YKD4MvMYCul7egdrT/zv5vFbQgjNQ74672fNweaztkR65V8y29
# u5PL2sf01p+uche0Zu4tSig+GsQ6ZQl9tjPRAY/3ITBHDeIYyvq8Wne9+7NoPLhx
# DSO6dtX7YCuQ4zcTP3SE6MvB4b5NighdtvoZVaYk1lXpjUTfdmKoX1ABq1sJbULS
# nSi0Qd4vvl3mZ9jxwv9dR/nlZP62lrZYZq7LPtHD6BlmclB5PT89DnSm1sjaZnFH
# rKzOsmq5GlmL5SFugCCZOoKz133FJeQaFMcXBZSCQjNABWBbHIRCE1ysHHG83Ddo
# nRmnC8EOlYeRwTWz/QCz6q0riOIbYyC/A2BgUEpu9/9EymrTsyMr2/zS8GdEybQ5
# W7f0WrcrmKB/Y62+g6TmfOS8NtU+L1jGoKNG6Q5RlfJwZu8J/Q9dl4OxyHKuy78+
# wm6HsF7uAizpsWh63UUaoK/OGQiBG3NJ+kef5eWpnva4ZJfhAnqYTAZD1uHgf8Vf
# Qjnl0BB2YXzK9WaTqde8d+8qCxVKr5hJYvbO+X3+2k5PCirUK/SboreX+xUhVaQE
# hVDYqlatyPttI7Z2IrkhMzwFvc+p0QeyMiNmo2cBZejx8icDOcUidwymDUYqGPE7
# MA8vtKW3feeSSYJsCEkuUO/vAgMBAAGjggE2MIIBMjAdBgNVHQ4EFgQUOlQhO/zG
# lqK99UkNL/Gu/AryN9gwHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIw
# XwYDVR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
# cy9jcmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3Js
# MGwGCCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENB
# JTIwMjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcD
# CDANBgkqhkiG9w0BAQsFAAOCAgEAgMDxWDTpGqLnFoPhm/iDfwHGF8xr2NbrJl8e
# gEg2ThTJsTf0wBE+ZQsnYfrRmXBbe6sCXLVN70qPuI+OEbN5MOai7Bue1/4j5VTk
# WquH5GZeVat2N+dD7lSUWp0dU8j+uBhBL5GFSmoDVVm+zW2GR2juPI1v254AJTb2
# l458anlkJjGvmYn2BtRS13h/wDR7hrQaI7BgdyHWAV5+HEj5UhrIrrvtwJiivSaU
# EA3qK6ZK/rZIQv/uORDkONw+2pHHIE1SXm/WIlhrVS2HIogfr3JjqvZion6LJSD7
# 41j8xVDLiClwAbspHoVFjxtxBcMjqPx6aWCJS8vjSoTnhkV4PO55mqsM7Q8XQRGQ
# hA7w4zNQOJu9kD4xFdYpPUmLN/daIcEElofBjGz+sEd1B4yqqIk3u2G4VygTXFmt
# hL8chSo7r+GIvTqWKhSA/sanS4N3jCgCCe3FTSJsp4g5nwavLvWAtzcOIvSRorGm
# AeN0m2wgzBK95T/qgrGGDXSos1JNDWRVBnP0qsw1Qoq5G0D8hxvQPs3X43KBv1GJ
# l0wo5rcC+9OMWxJlB63gtToQsA1CErYoYLMZtUzJL74jwZk/grpHEQhIhB3sneC8
# wzGKJuft7YO/HWCpuwdChIjynTnBh+yFGMdg3wRrIbOcw/iKmXZopMTQMOcmIeIw
# JAezA7AwggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3
# DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIw
# MAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAx
# MDAeFw0yMTA5MzAxODIyMjVaFw0zMDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1l
# LVN0YW1wIFBDQSAyMDEwMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# 5OGmTOe0ciELeaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/
# XE/HZveVU3Fa4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1
# hlDcwUTIcVxRMTegCjhuje3XD9gmU3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7
# M62AW36MEBydUv626GIl3GoPz130/o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3K
# Ni1wjjHINSi947SHJMPgyY9+tVSP3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy
# 1cCGMFxPLOJiss254o2I5JasAUq7vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF80
# 3RKJ1v2lIH1+/NmeRd+2ci/bfV+AutuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQc
# NIIP8BDyt0cY7afomXw/TNuvXsLz1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahha
# YQFzymeiXtcodgLiMxhy16cg8ML6EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkL
# iWHzNgY1GIRH29wb0f2y1BzFa/ZcUlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV
# 2xo3xwgVGD94q0W29R6HXtqPnhZyacaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIG
# CSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUp
# zxD/LwTuMB0GA1UdDgQWBBSfpxVdAF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBT
# MFEGDCsGAQQBgjdMg30BATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jv
# c29mdC5jb20vcGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYI
# KwYBBQUHAwgwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGG
# MA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186a
# GMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3Br
# aS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsG
# AQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcN
# AQELBQADggIBAJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1
# OdfCcTY/2mRsfNB1OW27DzHkwo/7bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYA
# A7AFvonoaeC6Ce5732pvvinLbtg/SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbz
# aN9l9qRWqveVtihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6L
# GYnn8AtqgcKBGUIZUnWKNsIdw2FzLixre24/LAl4FOmRsqlb30mjdAy87JGA0j3m
# Sj5mO0+7hvoyGtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0
# SCyxTkctwRQEcb9k+SS+c23Kjgm9swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxko
# JLo4S5pu+yFUa2pFEUep8beuyOiJXk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFm
# PWn9y8FBSX5+k77L+DvktxW/tM4+pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC482
# 2rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7
# vzhwRNGQ8cirOoo6CGJ/2XBjU02N7oJtpQUQwXEGahC0HVUzWLOhcGbyoYIC0jCC
# AjsCAQEwgfyhgdSkgdEwgc4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNv
# MSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo2MEJDLUUzODMtMjYzNTElMCMGA1UE
# AxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUA
# anQzrZW9TB93Ve7Pa4UPao2ffK2ggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWlj
# cm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFt
# cCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIFAOeHVQYwIhgPMjAyMzAyMDMxMzQw
# MjJaGA8yMDIzMDIwNDEzNDAyMlowdzA9BgorBgEEAYRZCgQBMS8wLTAKAgUA54dV
# BgIBADAKAgEAAgIkWgIB/zAHAgEAAgIQ+zAKAgUA54imhgIBADA2BgorBgEEAYRZ
# CgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0G
# CSqGSIb3DQEBBQUAA4GBADofAEolhzNabCprZ+KXEd87Dfcls65q1SfNOdy51OlC
# 0riLxyHQcuLlVDkuz8z3jswov/cMndZjVD6nU+t11HZHIVo7zecSeyGzKdNdCn/N
# URfD4qE3xAtDMGKEdlv8sZNGbFU2aaytl87zneUhviyXA9+C+O4GBW5m8iPpelS7
# MYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMA
# AAGmWUWDOU2e60sAAQAAAaYwDQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJ
# AzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgEn3TgCo6DNw0TaQnXouV
# ptIMaMOkr/4e0FOYbMS8ZT0wgfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCCD
# CxmLwz90fWvhMKbJTAQaKt3DoXeiAhfp8TD9tgSrDTCBmDCBgKR+MHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABpllFgzlNnutLAAEAAAGmMCIEIP+L
# IbiBLMLssQXQHlUnWLRaM/V8hHaQuagpT3/8wQt4MA0GCSqGSIb3DQEBCwUABIIC
# AJohukH5sfi9XR2VAbjC2djGZyb7v72uEmm+jXgn+oqX/cfe9GAp68yk1bxkNv0l
# Oo7WraYLDQvTEsLu/850tnyNA5OUTyrMdRRorEXwhjp5z/rfkcuvhIyW+n51RHrr
# Y81aKCN/VnmzeXqwnuKry6KUy1BfPcbtW607dPsqrQTSzSZHdWk+onp6vEa+6bQO
# csVWiRi1OfJ0qiPhcVW8yEEtOX77Y/oS/Ianl/56dztlIl5yXArChrEbRv0Mv5p2
# u6tlRsvn5lQAXQ8MnFhM4zOH3cT/272x8DqNCnF2XD0U/8a/ebO1aUYbWndQi1zb
# utedk1RvAtq6s6yjQGh9RZa3kPaYUfLHhd6g+BIJKRZkLf/2tHf581WIb+Z/zB4V
# cOz9YfBNvWPvmEyWv1RY11sKbI+zEepiQB8yam1MDw+l2Od4LN+W0Ho1ToodnLBH
# MdqDbqazywQsXr/VfmJTkKHQ1Cm8Guf25t/r0pAZe5pKBTuukxXpvvI6oGAX2N7h
# iV6GI41QzS0IY0iS8Ca9NHiayHbfvGyAyg2GoZx4w10ny094ho50x5WfPdFEHJKJ
# ONjNaHsTZxd+e/7VtyZoUweomaYUzAKL2sVTrQ5NGcemMJC7RURSta8+tupN465Z
# ebPGm8sueMKj5jgLuEQa3dFGmH3uaMY0ePTH6oOePqJL
# SIG # End signature block
