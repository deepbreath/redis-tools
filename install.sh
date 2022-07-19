#! /bin/bash

# temp file of rdt.sh
TEMP_RDT_FILE="./rdt.sh.$$"

# target file of rdt.sh
TARGET_RDT_FILE="./rdt.sh"

# update timeout(sec)
SO_TIMEOUT=60

# default downloading url
RDT_FILE_URL="https://github.com/deepbreath/redis-tools/releases/download/init/rdt.sh"

# exit shell with err_code
# $1 : err_code
# $2 : err_msg
exit_on_err()
{
    [[ ! -z "${2}" ]] && echo "${2}" 1>&2
    exit ${1}
}

# check permission to download && install
[ ! -w ./ ] && exit_on_err 1 "permission denied, target directory ./ was not writable."

if [ $# -gt 1 ] && [ $1 = "--url" ]; then
  shift
  RDT_FILE_URL=$1
  shift
fi

# download from aliyunos
echo "downloading... ${TEMP_RDT_FILE}"
curl \
    -sLk \
    --connect-timeout ${SO_TIMEOUT} \
    $RDT_FILE_URL \
    -o ${TEMP_RDT_FILE} \
|| exit_on_err 1 "download failed!"

# write or overwrite local file
rm -rf rdt.sh
mv ${TEMP_RDT_FILE} ${TARGET_RDT_FILE}
chmod +x ${TARGET_RDT_FILE}

# done
echo "Redist Tool install successed."
