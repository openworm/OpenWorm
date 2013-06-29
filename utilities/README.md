OpenWorm Utilities
==================

##OpenWorm Developement Environment Builder

File: **build_dev_environment.py**

This script will download, extract and build files necessary to start with Geppetto developement on your local machine.

This script downloads the following:
- Virgo Server
- Eclipse Juno IDE for JEE Developers
- org.geppetto.core Bundle
- org.geppetto.model.sph Bundle
- org.geppetto.solver.sph Bundle
- org.geppetto.simulator.sph Bundle
- org.geppetto.simulation Bundle
- org.geppetto.frontend Bundle
- org.geppetto Bundle

After downloading Virgo Server and Eclipse, they will be extracted to a directory specified by "--repository-dir". If no directory was specified "$HOME/openworm_dev" will be used.
###Eclipse Plugins installed

- org.eclipse.egit.feature.group
- org.eclipse.virgo.ide.feature.feature.group
- org.eclipse.egit.import.feature.group
- org.eclipse.m2e.feature.feature.group
- org.eclipse.mylyn.github.feature.feature.group
- org.springframework.ide.eclipse.feature.feature.group
- com.vmware.vfabric.ide.eclipse.tcserver.feature.group
- org.springframework.ide.eclipse.batch.feature.feature.group
- org.springframework.ide.eclipse.integration.feature.feature.group
- org.springframework.ide.eclipse.maven.feature.feature.group
- org.springframework.ide.eclipse.osgi.feature.feature.group
- org.springframework.ide.eclipse.security.feature.feature.group
- org.springframework.ide.eclipse.data.feature.feature.group,
- org.springframework.ide.eclipse.webflow.feature.feature.group
- org.springframework.ide.eclipse.mylyn.feature.feature.group
- org.springframework.ide.eclipse.aop.feature.feature.group
- com.vmware.vfabric.ide.eclipse.tcserver.insight.feature.group
- org.springframework.ide.eclipse.uaa.feature.feature.group

###Requirements


OS: Linux, OS X

[Python 2.7](http://python.org)

[Python Fabric API](http://docs.fabfile.org/en/1.6/)

[Maven](http://maven.apache.org/index.html)

[Git](http://git-scm.com/)

[JAVA SDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

[OpenCL](http://www.khronos.org/opencl/)


###Usage
```
build_dev_environment.py [-h] [--clone-method CLONE_METHOD]
                                [--virgo-version VIRGO_VERSION]
                                [--virgo-download-location VIRGO_DOWNLOAD_LOCATION]
                                [--repository-dir REPOSITORY_DIR]
                                [--skip-jdk-check SKIP_JDK_CHECK]
```

####Runtime options
```
--clone-method
description: Select method to clone github repository
options: SSH,HTTP,Git-ReadOnly
default: SSH
required: No

--virgo-version
description: Virgo Version to download
default: 3.6.0.RELEASE
required: No

--virgo-download-location
description: Download location for Virgo Server. Must be in quotes
required: No

--repository-dir
description: Directory for OpenWorm bundles and Virgo server. Relative to your home dir
required: No
default: openworm_dev

--skip-jdk-check
description: Skip OpenJDK check and allow script to continue. (not recommended)
Usage: --skip-jdk-check=1
required: No
default: 0
```