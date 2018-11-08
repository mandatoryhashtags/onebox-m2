-- Clear the base_url
UPDATE 
    `core_config_data` SET value = replace(replace(value, ".org", ".test"), ".com", ".local") 
WHERE
    `path` = 'web/unsecure/base_url'
    OR `path` = 'web/secure/base_url'
    OR `path` = 'admin/url/custom'
    OR `path` = 'web/unsecure/base_link_url'
    OR `path` = 'web/secure/base_link_url';
 
-- Clear the JS
UPDATE `core_config_data`
    SET `value` = '{{base_url}}/js/' 
WHERE
   `path` = 'web/unsecure/base_js_url'
   OR `path` = 'web/secure/base_js_url';
 
-- Clear the media path
UPDATE `core_config_data`
    SET value = '{{base_url}}/media/' 
WHERE
    `path` = 'web/unsecure/base_media_url'
    OR `path` = 'web/secure/base_media_url';
 
-- Clear the skin path
UPDATE `core_config_data`
    SET value = '{{base_url}}/skin/' 
WHERE
   `path` = 'web/unsecure/base_skin_url'
   OR `path` = 'web/secure/base_skin_url';
 
-- Clear the cookie domain
UPDATE `core_config_data`
    SET value = ''
WHERE 
    `path` = 'web/cookie/cookie_domain'
    OR `path` = 'web/cookie/cookie_path';

-- Disable varnish locally (if you want to work with it, enable it manually and set config as necessary)
UPDATE `core_config_data`
    SET value = '1'
WHERE
    `path` = 'system/full_page_cache/caching_application';

-- Switch off JS/CSS merging and minification (causes huge loading times)
UPDATE `core_config_data`
    SET value = '0' 
WHERE
   `path` = 'dev/js/merge_files'
   OR `path` = 'dev/js/minify_files'
   OR `path` = 'dev/css/merge_css_files'
   OR `path` = 'dev/css/minify_files';