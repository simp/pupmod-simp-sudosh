Summary: Sudosh Puppet Module
Name: pupmod-sudosh
Version: 4.1.0
Release: 4
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: pupmod-rsyslog >= 5.0.0
Requires: pupmod-logrotate >= 2.0.0-0
Requires: puppet >= 3.3.0
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0
Obsoletes: pupmod-sudosh-test

Prefix: /etc/puppet/environments/simp/modules

%description
This Puppet module provides the capability to use Sudosh with
logging to rsyslog.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/sudosh

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/sudosh
done

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/sudosh

%files
%defattr(0640,root,puppet,0750)
%{prefix}/sudosh

%post
#!/bin/sh

if [ -d %{prefix}/sudosh/plugins ]; then
  /bin/mv %{prefix}/sudosh/plugins %{prefix}/sudosh/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Mon Nov 09 2015 Chris Tessmer <chris.tessmer@onypoint.com> - 4.1.0-4
- migration to simplib and simpcat (lib/ only)

* Fri Jul 31 2015 Kendall Moore <kmoore@keywcorp.com> - 4.1.0-3
- Updated to use the new rsyslog module.

* Fri Feb 27 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-2
- Updated to use the new 'simp' environment.
- Changed calls directly to /etc/init.d/rsyslog to '/sbin/service rsyslog' so
  that both RHEL6 and RHEL7 are properly supported.

* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-1
- Changed puppet-server requirement to puppet

* Fri Jan 10 2014 Nick Markowski <nmarkowski@keywcorp.com> - 4.1.0-0
- Updated module for puppet3/hiera compatibility, and optimized code for lint tests,
  and puppet-rspec.

* Fri Jan 18 2013 Maintenance
4.0.0-5
- Create a Cucumber test that adds a user to the admin group and verifies that sudosh and sudosh-replay works.

* Tue Oct 23 2012 Maintenance
4.0.0-4
- Updated the rsyslog rule to be more concise.

* Wed Apr 11 2012 Maintenance
4.0.0-3
- Moved mit-tests to /usr/share/simp...
- Updated pp files to better meet Puppet's recommended style guide.

* Fri Mar 02 2012 Maintenance
4.0.0-2
- Improved test stubs.

* Mon Dec 26 2011 Maintenance
4.0.0-1
- Updated the spec file to not require a separate file list.

* Mon Nov 07 2011 Maintenance
4.0.0-0
- Fixed call to rsyslog restart for RHEL6.

* Tue Jan 11 2011 Maintenance
2.0.0-0
- Refactored for SIMP-2.0.0-alpha release

* Tue Oct 26 2010 Maintenance - 1-1
- Converting all spec files to check for directories prior to copy.

* Thu Aug 19 2010 Maintenance
1.0-0
- Initial creation
