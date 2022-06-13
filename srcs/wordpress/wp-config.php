<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'newuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '4z&e|Xdr3d].zXVT?dM8SYu`hM@})5Bn?%-2Y3mm[s;vmzXnR<|} @_|R7a{f3n{');
define('SECURE_AUTH_KEY',  'Rw29X|F>T+uzA*3/mZZ8`Pu#App|35Cz8_(cc~A(j0l.V;}ZGF|iF!|`D,~q3f{f');
define('LOGGED_IN_KEY',    'a}?s K^g<MEw}>Y|:m6M#U6DDX:hvS[oYB`XQJgP->i::dj/U^,D:RrQkkOK+rwv');
define('NONCE_KEY',        'BD]8q(%uKA6prSso&;1MsT)LvmO;u|#@# P@-n9kR{56#-w&)>g@-v2/(Wrg#s,/');
define('AUTH_SALT',        'bK/`A~+h2kq Vvj?O#*0(7-*bEd6Hpx6V~8*~Nw ?ILcAWD5c3V>r40DtgB<yHvO');
define('SECURE_AUTH_SALT', '3t|fLS)DpGOu}-05L9Aa(n-<@ v$PT,wqL&@G@(lgP|u|8.M:N;S[!4u9c[R|Sa!');
define('LOGGED_IN_SALT',   '1.YbmYTozM> JoP_0`*#a,x1ckQCn:.o|~9 6{|96jJRURPCHWy%{(omD[EiPpJ1');
define('NONCE_SALT',       'K;dAB16NcR-jjH-vP>LXU$bYI6,:nysRjs97S9[54CF$G`Iht[wL^j/.X``~2[}!');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'sjhd_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );