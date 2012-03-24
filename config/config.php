<?php

$config=array(

    # author name used in documentation
    'docs.author' => 'Rohan',

    # licence for your code
    'docs.license' => '',

    # copyright for your (generated) code
    'docs.copyright' => 'FHF (lftechnology)',

    # database type
    'db.type' => 'mysql',

    # database host
    'db.host' => 'localhost',

    # database unix socket (currently usful for mysql unix socket. leave empty if you want to use host)
    'db.socket' => '',

    # database port
    'db.port' => '3306',

    # database user
    'db.user' => 'root',

    # database password
    'db.password' => 'password',

    # if enabled, to add require_once to the model file to include the mapper file,
    # and in the mapper file to include the dbtable file.
    # usful if you don't have class auto-loading.
    # if you're using Zend Framework's MVC you can probably set this to false
    'include.addrequire' => false,
    
	# include path with inclusion of files based upon (type)_(table_name).inc
	# Either relative path to parent folder or absolute path
    'include.path' => 'includes',

    # default namespace name
    'namespace.default' => '',

    # The Cache Manager name in the Zend Registry. Leave blank to ignore
    'cache.manager_name' => '',

    # The Cache name to use inside the cache manager. Ignored if manager_name is blank
    'cache.name' => 'model',

    # The Zend Log name in the Zend Registry. Leave blank to ignore
    'log.logger_name' => 'log',

);
