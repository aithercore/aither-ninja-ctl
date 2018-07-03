#!/bin/zsh
#
#   This file is part of Dash Ninja.
#   https://github.com/elbereth/dashninja-ctl
#
#   Dash Ninja is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Dash Ninja is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Dash Ninja.  If not, see <http://www.gnu.org/licenses/>.
#

# Disable logging by default
updatelog=/dev/null
statuslog=/dev/null
votesrrdlog=/dev/null
balancelog=/dev/null
portchecklog=/dev/null
blockparserlog=/dev/null
autoupdatelog=/dev/null

# If parameter 1 is log then enable logging
if [[ "$1" == "log" ]]; then
  rundate=$(date +%Y%m%d%H%M%S)
  updatelog=log/update.$rundate.log
  statuslog=log/status.$rundate.log
  votesrrdlog=log/votesrrd.$rundate.log
  balancelog=log/balance.$rundate.log
  portchecklog=log/portcheck.$rundate.log
  blockparserlog=log/blockparser.$rundate.log
  autoupdatelog=log/autoupdate.$rundate.log
fi

# Sequentially run scripts
#/mnt/d/Nginx/www/aither-ninja-ctl/aitherdupdate >> $updatelog
/mnt/d/Nginx/www/aither-ninja-ctl/dmnctl status >> $statuslog
#/mnt/d/Nginx/www/aither-ninja-ctl/dmnvotesrrd >> $votesrrdlog
/mnt/d/Nginx/www/aither-ninja-ctl/dmnblockparser >> $blockparserlog

# Concurrently run scripts
/mnt/d/Nginx/www/aither-ninja-ctl/dmnbalance >> $balancelog &
/mnt/d/Nginx/www/aither-ninja-ctl/dmnportcheck db >> $portchecklog &
/mnt/d/Nginx/www/aither-ninja-ctl/dmnautoupdate >> $autoupdatelog &
