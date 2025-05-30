local id = 'projects/forestdatapartnership/assets/community_forests/ForestPersistence_2020';
local subdir = 'forestdatapartnership';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local version = 'v0';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'Forest Persistence ' + version,
  'gee:type': ee_const.gee_type.image,
  description: |||

    **Note: This dataset is not yet peer-reviewed.  Please see the GitHub 
    README associated with this model for more information.**

    This image provides a per-pixel score (in [0, 1]) that indicates whether 
    the pixel area is occupied by undisturbed forest in year 2020.

    These scores are provided at 30 meter resolution, and have
    been generated by a convergence of evidence approach to combining multiple 
    forest cover data sets into a level of continuous support for the presence 
    of undisturbed forest, defined as naturally regenerating forest with 
    "no clearly visible indications of human activities and the ecological 
    processes are not significantly disturbed" or forests "predominantly 
    composed of trees established through natural regeneration."  The 
    numerical support, called ForestPersistence, is created from an ensemble of 
    existing datasets selected for their ability to describe forest 
    disturbance and management history, consistent with the definition.  

    This community data product is meant to evolve over time, as more data
    becomes available from the community and the model used to produce the
    maps continuously improves. To provide map-based feedback on this
    collection, please see our
    [Collect Earth Online instance](https://app.collect.earth/collection?projectId=50862)
    and follow
    [these instructions](https://collect-earth-online-doc.readthedocs.io/en/latest/collection/simplified.html).

    If you would like to provide general feedback or additional datasets to
    improve these layers, please reach out through
    [this form](https://goo.gle/fdap-data).

    For more information about this dataset, see 
    [the README](https://github.com/google/forest-data-partnership/blob/main/models/forests/README.md) 
    on Google's Forest Data Partnership GitHub site. For more information about 
    the Forest Data Partnership, visit the 
    [Forest Data Partnership website](https://www.forestdatapartnership.org/).

    **Limitations**: Geographic scope is limited to +/- 80 degrees latitude 
    and to calendar year 2020. Not all geographic regions are equally 
    represented. For example, China, Russia, Australia, New Zealand and other 
    countries lack regionally specific datasets in the ensemble. Boreal forest 
    may not be well represented. This dataset is built from existing datasets, 
    and any limitations and errors associated with those datasets may be 
    present. Landsat TimeLapse is a Google developed product that has not 
    been used with LandTrendr previously. A probability sample of these types 
    of forest cover coincident with the year 2020 is not available, making 
    accuracy difficult to assess.


  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  'gee:categories': ['forest-biomass'],
  keywords: [
    'primary_forest',
    'undisturbed_forest',
    'deforestation',
    'eudr',
    'biodiversity',
    'conservation',
    'pre_review',
  ],
  providers: [
    ee.producer_provider(
      'Produced by Google for the Forest Data Partnership',
      'https://www.forestdatapartnership.org/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2020-12-31T23:59:59Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'value',
        description: |||
          A value that indicates numerical support for the pixel being occupied 
          by undisturbed forest in year 2020.
        |||,
      },
    ],
    gsd: [
      30.0,
    ],
    value: { minimum: 0, maximum: 1, 'gee:estimated_range': false },
    // One or more band visualizations.
    'gee:visualizations': [
      // Example with one band.
      {
        display_name: 'Forest persistence value at this pixel',
        lookat: { lon: 110, lat: 0, zoom: 4 },
        image_visualization: { band_vis: { bands: ['value'] } },
      },
    ],
  },
  'sci:citation': |||
    [Forest Data Partnership](https://github.com/google/forest-data-partnership/blob/main/models/forests/README.md)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license) + |||

    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced by Google for the Forest
    Data Partnership."

    Contains modified Copernicus Sentinel data [2015-present].
    See the [Sentinel Data Legal Notice](
      https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice).
  |||,
}
