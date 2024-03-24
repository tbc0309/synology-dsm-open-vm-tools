### Generic variables and functions
### -------------------------------

if [ -z "${SYNOPKG_PKGNAME}" ] || [ -z "${SYNOPKG_DSM_VERSION_MAJOR}" ]; then
  echo "Error: Environment variables are not set." 1>&2;
  echo "Please run me using synopkg instead. Example: \"synopkg start [packagename]\"" 1>&2;
  exit 1
fi

USER="sc-open-vm-tools"
EFF_USER="sc-open-vm-tools"
# start-stop-status script redirect stdout/stderr to LOG_FILE
LOG_FILE="${SYNOPKG_PKGVAR}/${SYNOPKG_PKGNAME}.log"

# Service command has to deliver its pid into PID_FILE
PID_FILE="${SYNOPKG_PKGVAR}/${SYNOPKG_PKGNAME}.pid"


### Package specific variables and functions
### ----------------------------------------


# Package specific behaviors
# Sourced script by generic installer and start-stop-status scripts
VMTOOLS_DIR=${SYNOPKG_PKGDEST}
VMTOOLS_DAEMON="${VMTOOLS_DIR}/bin/vmtoolsd"
CONF_FILE=${VMTOOLS_DIR}/etc/vmware-tools/tools.conf
PLUGINS_PATH=${SYNOPKG_PKGDEST}/lib/open-vm-tools/plugins/vmsvc/
COMMON_PATH=${SYNOPKG_PKGDEST}/lib/open-vm-tools/plugins/
LOG_FOLDER=${SYNOPKG_PKGDEST}/var/log
SCRIPT_PATH=${VMTOOLS_DIR}/etc/vmware-tools
PATH="${VMTOOLS_DIR}/bin:${PATH}"

SERVICE_COMMAND="${VMTOOLS_DAEMON} -b ${PID_FILE} -c ${CONF_FILE} --plugin-path=${PLUGINS_PATH} --common-path=${COMMON_PATH}"

service_postinst ()
{
    mkdir -p ${LOG_FOLDER} 	
    cat > ${CONF_FILE} << EOF
# bindir = "${SYNOPKG_PKGDEST}/bin"
# libdir = "${SYNOPKG_PKGDEST}/lib"
[vmtools]
     disable-tools-version = false
[setenvironment]
    vmsvc.LOCALE = it
[logging]
    log = true
    vmsvc.level = message
    vmsvc.handler = file
    vmsvc.data = ${LOG_FOLDER}/vmsvc.${USER}.log

    vmtoolsd.level = message
    vmtoolsd.handler = file
    vmtoolsd.data = ${LOG_FOLDER}/vmtoolsd.${USER}.log

[powerops]
    poweron-script=${SCRIPT_PATH}/poweron-vm-default
    poweroff-script=${SCRIPT_PATH}/poweroff-vm-default
    resume-script=${SCRIPT_PATH}/resume-vm-default
    suspend-script=${SCRIPT_PATH}/suspend-vm-default

EOF
}

service_postuninst ()
{
    # Remove link
    rm -f ${VMTOOLS_DIR}

}
