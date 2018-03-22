$pkg_name = "win-python2"
$pkg_origin = "indellient"
$pkg_version = "2.7.14"
$pkg_maintainer = "Indellient Inc. <skylerl@indellient.com>"
$pkg_description = "Installs python2 for windows"
$pkg_upstream_url = "https://www.python.org/ftp/python/$pkg_version/python-$pkg_version.msi"
$pkg_bin_dirs = @("bin", "bin/Scripts")

function Invoke-Download {
  Write-Host "Downloading $pkg_upstream_url"
  Invoke-WebRequest -URI $pkg_upstream_url -OutFile "$HAB_CACHE_SRC_PATH\python-$pkg_version.msi"
  Invoke-WebRequest -URI "https://bootstrap.pypa.io/get-pip.py" -OutFile "$HAB_CACHE_SRC_PATH\get-pip.py"
}
function Invoke-Verify { }

function Invoke-Build { }

function Invoke-Install {
  $dir="$pkg_prefix\bin"
  Write-Host "Installing python binaries to $dir"

  Start-Process -Wait -FilePath msiexec -ArgumentList /a, "$HAB_CACHE_SRC_PATH\python-$pkg_version.msi TARGETDIR=$dir  ADDLOCAL=pip", "ALLUSERS=1" , /qn

  $env:Path = "$pkg_prefix\bin";

  Write-Host "Installing pip to $dir\Scripts"
  Start-Process -Wait -FilePath python -ArgumentList $HAB_CACHE_SRC_PATH\get-pip.py
}