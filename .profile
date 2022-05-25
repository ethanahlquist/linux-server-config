##############################################################################   
# $URL:    https://izlc.llnl.gov/gitlab/LC/cfengine3/-/blob/main/llnl/toss/3/nas/skel/profile $                                                                       
# $Author: Michael Gilbert $                                                                    
# $Date:   2019-12-18 18:30:37 +0000 $                                                                      
# $Rev:    273805f6987158d65486d683171972484020878a $                                                                       
##############################################################################  
# *** This file was added to CFEngine by copying from /usr/global/admin/nas/skel/ (12/18/19 mg) ***
#
#
# .profile file 1.3 jmw
#
# WARNING:
# THIS .PROFILE FILE IS FOR ALL HOSTS USING THE COMMON HOME DIRECTORY STRUCTURE.
# **  DO NOT COPY OVER IT WITH A HOST-SPECIFIC .PROFILE FILE.  ** 

#(But if you do, this file can be re-copied back from /gadmin/etc/skel/.profile)

# This is the master .profile file read in after the global system profile.
# It is not read for subsequent shells.  It is for setting up terminal
# and global environment characteristics.
#
# This .profile file will determine current host (HOST_GRP) and platform 
# type (SYS_TYPE) and will execute correct additional .profile files. 
#
# HOST_GRP is the current host name or the name of a group of hosts such as:
#
#        HOSTS:                        HOST_GRP
#      OCF Compaqs: Tera,GPS,Tc2k        compaq 
#      SCF Compaqs: SC cluster           forest
#      OCF ASCI IBMs:                    blue
#      SCF ASCI IBMs: Sky nodes          sky
#                     White, ice         white   
#      OCF/SCF SGI viz servers           irix_desktop
#      OCF/SCF Linux systems             linux
#      OCF/SCF Solaris desktop servers   sol_desktop
#                      (Lucy & Denali)
 
# THE USER'S HOST-SPECIFIC .PROFILE ENTRIES BELONG IN $HOME/.profile.<HOST_GRP>
#
# EDIT THIS FILE ONLY TO ADD YOUR CUSTOMIZATIONS WHICH APPLY TO ALL HOST_GRPS
# AND ALL PLATFORMS USING COMMON HOME DIRECTORIES.  ADD HOST_GRP AND PLATFORM
# SPECIFIC CUSTOMIZATIONS TO $HOME/.profile.<HOST_GRP> or 
# $HOME/.profile.<platform>.

# Define system type if not already done in global.profile file 
if [ ! "$SYS_TYPE" ]; then
  if [ -r /etc/home.config ]; then
     SYS_TYPE=`grep SYS_TYPE /etc/home.config | cut -d" " -f2`
     export SYS_TYPE
  else
     echo ""
     echo .profile WARNING: SYS_TYPE not defined.  See system administrator to verify 
     echo system is set up properly for use of common home directory structure.
     echo User login files not executed.
     echo ""
     return
  fi
fi

# Check that HOST_GRP name is defined 
if [ ! "$HOST_GRP" ]; then
  if [ -r /etc/home.config ]; then
    HOST_GRP=`grep HOST_GRP /etc/home.config | cut -d" " -f2`
    export HOST_GRP
  else
     echo ""
     echo .profile WARNING:  HOST_GRP not defined.  See system administrator to verify  
     echo system is set up properly for use of common home directory structure.
     echo User login files not executed.
     echo ""
     return

  fi
fi
 
# Set variable to show that .profile has been executed (for MacX usage)
GLOGIN=1
export GLOGIN

# If ENVIRONMENT has not been set then set it appropriately
if [ ! "$ENVIRONMENT" ]; then
  case $-
  in
    *i*)  ENVIRONMENT=INTERACTIVE; export ENVIRONMENT;;
    *)    ENVIRONMENT=BATCH; export ENVIRONMENT
  esac
fi

# source host-specific login files

# HERE IS WHERE THE USER`S HOST-SPECIFIC FILE IS EXECUTED:
if [ -f $HOME/.profile.${HOST_GRP} ]; then
  . $HOME/.profile.${HOST_GRP}
fi

# Execute user platform-specific file if it exists:
if [ -f $HOME/.profile.${SYS_TYPE} ]; then
  . $HOME/.profile.${SYS_TYPE}
fi
 

# NON-HOST SPECIFIC, NON-PLATFORM SPECIFIC CUSTOMIZATIONS GO HERE:
# USER GENERIC CUSTOMIZATION:

#EXAMPLE USER CUSTOMIZATIONS TO APPLY ACROSS ALL COMMON HOME SYSTEMS

# path already has global and user host-specific values added
# PATH= $PATH:~:.

# EDITOR=vi; export EDITOR
# LPDEST=<enter_your_printer_name>; export LPDEST
# PRINTER=<enter_your_printer_name>; export PRINTER
# DISPLAY=desktop.llnl.gov:0.0; export DISPLAY
