$pkg_name = "win-python2"
$pkg_origin = "indellient"
$pkg_version = "2.7.14"
$pkg_maintainer = "Indellient Inc. <skylerl@indellient.com>"
$pkg_description = "Installs python2 for windows"
$pkg_upstream_url = "https://www.python.org/ftp/python/$pkg_version/python-$pkg_version.msi"
$pkg_bin_dirs = @("bin")

function Invoke-Download {
  Write-Host "Downloading $pkg_upstream_url"
  Invoke-WebRequest -URI $pkg_upstream_url -OutFile "$HAB_CACHE_SRC_PATH\python-$pkg_version.msi"
}
function Invoke-Verify { }

function Invoke-Build { }

function Invoke-Install {
  Write-Host "Installing to $pkg_prefix\bin"
  $dir="C:\Python27"

  Write-Host "*** DOES OBEY TARGETDIR=$pkg_prefix\bin, WILL STRIP USERS PYTHON FROM $dir, 5 SECONDS TO STOP ***"

  Start-Sleep -s 6

  Start-Process -Wait -FilePath msiexec -ArgumentList /i, "$HAB_CACHE_SRC_PATH\python-$pkg_version.msi TARGETDIR=$pkg_prefix\bin", /qn, /l*v, "$pkg_prefix\bin\install.log"
  Move-Item $dir\* $pkg_prefix\bin
}