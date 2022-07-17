#! /bin/bash

installed_path="${ASDF_DATA_DIR}/installs";

# Find all installed plugins
dirs=( ${installed_path}/* );

# Normalize plugin names
for((i=0;i<${#dirs[@]};i++))
do
    plugins+=("${dirs[$i]//${installed_path}\//}");
done

# Choosing needed plugin
PS3='Please select asdf plugin: ';
select plugin in ${plugins[@]};
do
    break;
done

# Find all installed plugin versions
dirs=( ${installed_path}/${plugin}/* );

# Normalize plugin version
for((i=0;i<${#dirs[@]};i++))
do
    versions+=("${dirs[$i]//${installed_path}\/${plugin}\//}");
done

# Choosing needed plugin
PS3="Please select asdf ${plugin} version: ";
select version in ${versions[@]};
do
    break;
done

asdf global ${plugin} ${version};
