#!/bin/tcsh
# kullanıcı adı ve parola ile giriş yapılabilen 
# kullanıcı adının belirli bir formatta olmasını gerektiren ve formatın kontrolünün yaıldıgı 
#ancak o formatla yazılmış kullanıcı adı ile giriş yapılabilen
#giriş yapıldıktan sonra verilen  belirli komutları sırasıyla calıstıran 
# komutlarda oluşan hatayı kullanıcıya donduren 
# hataların çözümü için kullanıcıya öneri sunan 
#ayrıca hataları bir error log dosyasına kaydeden programın csh kodu
 set log_error = "error.log"
 alias log_error_msg 'echo "`date` - \!:*" | tee -a '"$log_error" 
 # #!:* komutu, son kullanılan komutun tüm argümanlarını tekrar kullanır

 if (! -e $log_error) then
  touch $log_error
 endif

 set username = $1
 set password= $2

 if ("$username" == "" || "$password" == "") then
    log_error_msg "Username or jira cannot be empty!"
    exit 1
 endif

if ( $#argv != 2 ) then
    log_error_msg "Not enough/extra argument input (Enter username and jiraName!)"
    exit 1
endif

echo "$username" | grep -E '^(AKH)-[0-9]{5}$' > /dev/null
if ($status == 0) then
    echo "Login Successful! Welcome $username" 
else
    log_error_msg "Jiraname Format entered incorrectly"
    exit 1
endif

set tempdate = "`date`"
echo "$tempdate"

set my_list = ( \
    "mkdir A " \
    "cd B " \
    "git C" \
    "cd D" \
    "git checkout ${username}"  \
    "git submodule update --init --recursive"\
    "csh" \
    "setenv PATH1" \
    "setenv PATH2" \
    "setenv REPO PATH3" \
    "setenv PATH4" \
    "setenv PATH5" \
"setenv PATH6" \
"setenv PATH7" \
"setenv PATH8" \
)
# Komutları çalıştır ve hata kontrolü
foreach command ($my_list)
    echo "Running command: $command"
    echo "Komut çalışıyor"
   
    set output = (`$command` 2>&1)
    set status = $status


    if ($status != 0) then
        log_errors "Command '$command' failed: $output"
        echo "Error: Command '$command' failed. Check error.log for details."
        echo "Error details: $output"
       
        switch ($command)
            case "mkdir A":
              echo "Suggestion: 'mkdir' command creates directories. Check if the directory exists and has proper permissions." >&2
                exit 1
                breaksw
            case "cd B":
                echo "Suggestion: 'cd' command changes directory. The directory may not exist or permissions may be insufficient." >&2
                 exit 1
                breaksw
            case "git clone C":
                echo "Suggestion: 'git clone' command clones a remote repository. Check the remote URL and SSH key configuration." >&2
                exit 1
                breaksw
            case "cd D":
                echo "Suggestion: 'cd' command changes directory. The directory may not exist or permissions may be insufficient." >&2
                 exit 1
                breaksw
            case "git checkout ${username}":
                echo "Suggestion: 'git checkout' command changes branches. Verify the branch name and its existence." >&2
                exit 1
                breaksw
            case "git submodule update --init --recursive":
                echo "Suggestion: 'git submodule update' command updates submodules. Check Git configuration and submodule references." >&2
                 exit 1
                breaksw
           
            case "csh":
            echo "csh" >&2
                 exit 1
                 breaksw
            case "setenv PATH1":
                echo "   " >&2
                 exit 1
                breaksw
       case "setenv  PATH2":
                echo "   " >&2
                 exit 1
                breaksw
                 
            case "setenv REPO PATH3":
                echo "   " >&2
                 exit 1
                breaksw
                 
            case "setenv PATH4":
                echo "   " >&2
                 exit 1
                breaksw
                 
             case "setenv PATH5":
                echo "   " >&2
                 exit 1
                breaksw
                 
            case "setenv PATH6":
                echo "   " >&2
                 exit 1
                breaksw
                 
            case "setenv PATH7":
                echo "   " >&2
                 exit 1
                breaksw
                 
            case "setenv PATH8:
                echo "   " >&2
                 exit 1
                breaksw
        default:
                echo "Suggestion: Unknown command error. Ensure the command is correct and has proper permissions." >&2
                exit 1
                breaksw
          endsw
          exit 1
        endif
     end

echo "All commands executed successfully"
set tempdate = "`date`"
echo " $tempdate"

echo "\n Error log file content:"
cat $log_error

