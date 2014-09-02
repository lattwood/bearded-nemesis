#!/usr/bin/env bash
#
# Common shell functions used
#
# Also takes care of any environment bootstrapping required
#

# Vagrant clobbers the environment, and we don't want to use the ruby + gems
# that it provides. Too much hassle
unset GEM_HOME
unset GEM_PATH
unset RUBYLIB
unset RUBYOPT

# Used for displaying warnings
warn() {
	echo "$0:" "$@" >&2
}

# Used for early termination of the script
# Ex:
# die 127 "I'm sorry Dave, but I can't let you do that"
die () {
	rc=$1
	shift
	warn "$@"
	exit $rc
}

# if we have rbenv available, use that for ruby versions
[[ -x `which rbenv` ]] && eval "$(rbenv init -)"

# We need r10k, facter, and puppet
# r10k can be installed from a gem easily, but not facter and puppet

gem list -i r10k &> /dev/null
if [ $? -ne 0 ]; then
	echo "Installing r10k..."
	gem install r10k -q
fi

[[ -x `which facter` ]] || die 127 "You need to install facter!"
[[ -x `which puppet` ]] || die 127 "You need to install puppet!"

# rehash the environment, so r10k is on our path
[[ -x `which rbenv` ]] && rbenv rehash
