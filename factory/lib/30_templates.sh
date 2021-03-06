#!/bin/bash
set -e

# This is a library file. 
# It should be 'source'd only, if it is not we bail out here. 
if [[ "$0" = "$BASH_SOURCE" ]]; then
   echo "This file should not be executed directly, it should be 'source'd only. "
   exit 1;
fi

TEMPLATE_DIR="$SCRIPT_DIR/resources/templates/"

# load_template will load a template $1 from the template directory
# and replace ${$2} with $3, ${$4} with $5 etc. 
# echoes out the replaced template
function load_template() {
    # read the template then remove the argument
    TEMPLATE=`cat "$TEMPLATE_DIR/$1"`
    shift 1;

    # while we have a variable to substiute
    while [ ! -z "$1" ]
    do
        # do the substitution
        TEMPLATE="${TEMPLATE//\$\{$1\}/$2}"
        shift 2
    done;

    # finally echo out the template
    echo "$TEMPLATE"
}

# path where common apache files will be installed. 
WISSKI_COMMON_PATH="/etc/apache2/conf/wisski"