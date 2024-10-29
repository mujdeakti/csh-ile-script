# kullanıcı adı ve parola ile giriş yapılabilen 
# kullanıcı adının belirli bir formatta olmasını gerektiren ve formatın kontrolünün yaıldıgı 
#ancak o formatla yazılmış kullanıcı adı ile giriş yapılabilen
#giriş yapıldıktan sonra verilen  belirli komutları sırasıyla calıstıran 
# komutlarda oluşan hatayı kullanıcıya donduren 
# hataların çözümü için kullanıcıya öneri sunan 
#ayrıca hataları bir error log dosyasına kaydeden programın csh kodu

#!/bin/csh
 set log_error = "error.log"
 #alias log_error_msg echo "`date`" >> $log_error; ##error dosyası normal bir şekilde oluşuyor fakat içine hatalar yazılmıyor
 alias log_error_msg 'echo "`date` - \!:*" | tee -a '"$log_error" #error dosyası gwc de olusuyor
 #!:* komutu, son kullanılan komutun tüm argümanlarını tekrar kullanır
 #tee komutu, girdiyi hem ekrana yazdırır hem de bir dosyaya yazar. -a (append) seçeneği ise dosyaya ekleme yaparak yazmayı sağlar, 
 #yani mevcut içeriği silmeden sonuna ekleme yapıyor


#buradaki A,B,C,D.. . ve PATH1 , PATH2, PATH3V... diye giden seçenelşer yerine kullanmak istediğiniz pathleri girmelisiniz(pathler şirkete özel olduğu için buraya yazamıyorum)

 if (! -e $log_error) then
    touch $log_error
 endif

 set username = $1
 set jiraName = $2

 if ("$username" == "" || "$jiraName" == "") then
    log_error_msg "Username or jira cannot be empty!"
    exit 1
 endif

if ( $#argv != 2 ) then
    log_error_msg "Not enough/extra argument input (Enter username and jiraName!)"
    exit 1
endif

echo "$jiraName" | grep -E '^(AKH)-[0-9]{5}$' > /dev/null
if ($status == 0) then
    echo "Login Successful! Welcome $username" 
else
    log_error_msg "Jiraname Format entered incorrectly"
    exit 1
endif

set tempdate = "`date`"
mkdir -p A
if ($status != 0) then
    log_error_msg "mkdir -p command failed "
    echo "Suggestion: 'mkdir' command creates directories. Check if the directory exists and has proper permissions."
    exit 1
endif

cd B
if ($status != 0) then
    log_error_msg "cd command failed"
    echo "Suggestion: 'cd' command changes directory. The directory may not exist or permissions may be insufficient."
    exit 1
endif

git clone ssh://git@bitbucket.rbbn.com:C.git D
if ($status != 0) then
    log_error_msg "git clone command failed"
    echo "Suggestion: 'git clone' command clones a remote repository. Check the remote URL and SSH key configuration."
    exit 1
endif

cd D
if ($status != 0) then
    log_error_msg "cd gwc_src command failed"
     echo "Suggestion: Directory D' does not exist or is not in the current directory"
    exit 1
endif

git checkout $jiraName
if ($status != 0) then
    log_error_msg "git checkout command failed"
   echo  "Suggestion: 'git checkout' command changes branches. Verify the branch name and its existence."
    exit 1
endif

git submodule update --init --recursive
if ($status != 0) then
    log_error_msg "git submodule update command failed"
    echo "Suggestion: 'git submodule update' command updates submodules. Check Git configuration and submodule references." 

cd E
if ($status != 0) then
    log_error_msg "cd E failed"
   echo "Suggestion: Directory E does not exist or is not in the current directory"
    exit 1
endif

git checkout F
if ($status != 0) then
    log_error_msg "git checkout F command failed"
    echo " The branch named  "F" may not exist in the local Git repository ."
    exit 1
endif

csh 
if ($status!=0) then
log_error_msg "csh command failed"
echo "csh failed to initialize"

setenv G / PATH1
if ($status != 0) then
    log_error_msg " setenv G command failed"
    echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif

setenv REPO PATH2
if ($status != 0) then
   log_error_msg " setenv REPO PATH2 command failed"
   echo "Make sure that the PATH2 variable has a valid and appropriate value."
    exit 1
endif

setenv PATH3
if ($status != 0) then
    log_error_msg " setenv PATH3command failed"
    echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif
 
setenv PATH4
if ($status != 0) then
   log_error_msg "setenv PATH4 command failed"
   echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif
 
setenv BUILD_ PATH5
 if ($status != 0) then
   log_error_msg "setenv BUILD_PATH PATH5 command failed"
   echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif

setenv PATH6 
if ($status != 0) then
   log_error_msg "setenv ROOT_USR_DIR ${USE_SRC_ROOT}/gwc/gwc_src/DOs/root/gwc_fam_intel/i686/usr command failed"
   echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif
 
setenv OBJPATH ${USE_SRC_ROOT}/gwc/gwc_src/DOs
if ($status != 0) then
   log_error_msg "setenv OBJPATH ${USE_SRC_ROOT}/gwc/gwc_src/DOs command failed"
   echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif
 
setenv DO_VOB $OBJPATH
if ($status != 0) then
    log_error_msg "setenv DO_VOB $OBJPATH command failed"
    echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif
 
setenv GWC_TOOLS ${USE_SRC_ROOT}/gwc/gwc_src/packages/pkg/get_gwc_versions
if ($status != 0) then
  log_error_msg "setenv GWC_TOOLS command failed"
     echo "Might be invalid path or filename! Check the file name and path"
    exit 1
endif

echo "All commands executed successfully"
set tempdate = "`date`"
echo " $tempdate"

echo "\n Error log file content:"
cat $log_error
script.csh.txt
script.csh.txt showing.


