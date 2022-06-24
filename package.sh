Spec=XLAlertMessage.podspec

PodVersion=''

SpecSouce=''

current_path=$(
    cd "$(dirname "$0")"
    pwd
)

echo into $current_path
cd $current_path

function PrintCommands() {
    if [ "$SpecSouce" ]; then
        echo "pod $PodVersion spec lint $Spec --allow-warnings --sources=$SpecSouce"
    else
        echo "pod $PodVersion spec lint $Spec --allow-warnings"
    fi
    echo "pod $PodVersion repo push JFAISDKSpec $Spec --allow-warnings "
    echo "pod $PodVersion repo  update"
    if [ "$SpecSouce" ]; then
        echo "pod $PodVersion package $Spec --force --no-mangle --spec-sources=$SpecSouce"
    else
        echo "pod $PodVersion package $Spec --force --no-mangle"
    fi
}

function PodLintSpec() {

    if [ "$SpecSouce" ]; then
        echo "pod $PodVersion spec lint $Spec --allow-warnings --sources=$SpecSouce"

        validate=$(pod $PodVersion spec lint $Spec --allow-warnings --sources=$SpecSouce)
    else
        echo "pod $PodVersion spec lint $Spec --allow-warnings"

        validate=$(pod $PodVersion spec lint $Spec --allow-warnings)
    fi

    Not_Pass_Word="The spec did not pass validation"

    result=$(echo $validate | grep "${Not_Pass_Word}")

    if [[ "$result" != "" ]]; then
        echo $Not_Pass_Word
        exit
    fi

    echo "The spec did pass validation"
}

function PodRepoPush() {

    echo "pod $PodVersion repo trunk push $Spec --allow-warnings "

    Push_Result=$(pod $PodVersion trunk push $Spec --allow-warnings)
}

function PodRepoUpdate() {

    echo "pod $PodVersion repo  update"

    Push_Result=$(pod $PodVersion repo update)
}

function PodPackage() {

    if [ "$SpecSouce" ]; then
        echo "pod $PodVersion package $Spec --force --no-mangle --spec-sources=$SpecSouce"

        Package_Result=$(pod $PodVersion package $Spec --force --no-mangle --spec-sources=$SpecSouce)
    else
        echo "pod $PodVersion package $Spec --force --no-mangle"

        Package_Result=$(pod $PodVersion package $Spec --force --no-mangle)
    fi
    Configuration_Release="with configuration Release"

    result=$(echo $Package_Result | grep "${Configuration_Release}")

    if [[ "$result" != "" ]]; then
        echo "Framework Build Fail"
    else
        echo "Framework Build Success"
    fi
}
PrintCommands 
# PodLintSpec
# PodRepoPush
# PodRepoUpdate
# PodPackage
