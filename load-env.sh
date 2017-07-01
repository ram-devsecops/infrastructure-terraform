#!/bin/bash
OPT_CONFIG="$HOME/.terraform-env"
OPT_QUIET=0
OPT_HELP=0
OPT_VERBOSE=0

usage() {
echo -n "COMMAND: $(basename "$0") [options] -- Sets all terraform environment variables

OPTIONS:
    -h | --help     Shows this help text
    -v | --verbose  Outputs terraform variables and their values
    -q | --quiet    Disables all stdout
    -c | --config   To change where to load the config file. Defaults to ${OPT_CONFIG}

"
}

while true; do
  case "$1" in
    -v | --verbose ) OPT_VERBOSE=1; shift ;;
    -q | --quiet ) OPT_QUIET=1; shift ;;
    -h | --help ) OPT_HELP=1; shift ;;
    -c | --config ) OPT_CONFIG="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break;;
  esac
done

if [ "$OPT_HELP" -eq 1 ]; then
  usage && exit 0;
fi

if ! [ -f "$OPT_CONFIG" ]; then
  echo "Could not find config file ${OPT_CONFIG} . Make sure it exists and is executable (chmod a+x ${OPT_CONFIG})" && exit 1;
else
  # Export vars
  # shellcheck disable=SC1090
  source "$OPT_CONFIG"
fi

if [ "$OPT_VERBOSE" -eq 1 ]; then
  env | grep -E 'TF_VAR_'
elif [ "$OPT_QUIET" -eq 0 ]; then
  echo "Terraform ENV vars set 👍."
fi
