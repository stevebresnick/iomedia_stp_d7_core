#!/bin/bash

: ${DRUSH:=drush}
: ${DRUSH_ARGS:=}

LIGHTNING_FEATURES="lightning_admin lightning_article lightning_base lightning_blocks lightning_content lightning_edit lightning_featured lightning_files lightning_filter lightning_forms lightning_fpp lightning_identifiers lightning_image lightning_landing lightning_media lightning_metatags lightning_moderation lightning_page lightning_panels lightning_roles lightning_rules lightning_shortcuts lightning_sps lightning_tags lightning_token lightning_theme lightning_views lightning_wysiwyg"

# TODO: We should make sure that 'diff' is downloaded first!
$DRUSH $DRUSH_ARGS en -y diff

OVERRIDDEN=0
for lightning_feature in $LIGHTNING_FEATURES; do
  echo "Checking $lightning_feature..."
  if $DRUSH $DRUSH_ARGS features-diff $lightning_feature 2>&1 | grep -v 'Feature is in its default state'; then
    OVERRIDDEN=1
  fi
done

exit $OVERRIDDEN
