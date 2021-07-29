/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_module_oml
//
//  Desc:  This script must be run by the module's
//         OnModuleLoad event handler.
//
//  Author: David Bobeck 12Jan03
//
/////////////////////////////////////////////////////////
//#include "cnr_persist_inc"
#include "cnr_config_inc"

void main()
{
  sqlquery sql; string query; int sqlstep;

  // if cnr_misc table does not exist, create it
  query = "CREATE TABLE IF NOT EXISTS cnr_misc("
        + "player varchar(64) DEFAULT NULL,"
        + "tag varchar(64) DEFAULT NULL, "
        + "name varchar(64) DEFAULT NULL, "
        + "val text, "
        + "expire int(16) DEFAULT NULL, "
        + "last timestamp NOT NULL DEFAULT DEFAULT_TIMESTAMP, "
        + "PRIMARY KEY (player,tag,name))";
  sql = SqlPrepareQueryCampaign("db", query);
  sqlstep = SqlStep(sql);

  // change * to / to uncomment following section
  if (CNR_BOOL_RECIPE_DATA_IS_PERSISTENT_IN_SQL_DATABASE == TRUE)
  {
    // if cnr_devices table does not exist, create it
    query = "CREATE TABLE IF NOT EXISTS cnr_devices("
          + "sDeviceTag varchar(64) NOT NULL DEFAULT '', "
          + "sAnimation varchar(64) DEFAULT NULL, "
          + "bSpawnInDevice int(2) DEFAULT 0, "
          + "sInvTool varchar(64) DEFAULT NULL, "
          + "sEqpTool varchar(64) DEFAULT NULL, "
          + "nTradeType int(16) DEFAULT 0, "
          + "fInvToolBP real(32) DEFAULT 0, "
          + "fEqpToolBP real(32) DEFAULT 0, "
          + "PRIMARY KEY (sDeviceTag))";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    // if cnr_submenus table does not exist, create it
    query = "CREATE TABLE IF NOT EXISTS cnr_submenus("
          + "sKeyToMenu varchar(64) NOT NULL DEFAULT '', "
          + "sKeyToParent varchar(64) NOT NULL DEFAULT '', "
          + "sTitle varchar(64) NOT NULL DEFAULT '', "
          + "sDeviceTag varchar(64) NOT NULL DEFAULT '', "
          + "PRIMARY KEY (sKeyToMenu))";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    query = "CREATE INDEX sDeviceTag ON cnr_submenus (sDeviceTag)";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    // if cnr_recipes table does not exist, create it
    query = "CREATE TABLE IF NOT EXISTS cnr_recipes("
          + "sKeyToRecipe varchar(64) NOT NULL DEFAULT '', "
          + "sDeviceTag varchar(64) NOT NULL DEFAULT '', "
          + "sDescription varchar(64) NOT NULL DEFAULT '', "
          + "sTag varchar(64) NOT NULL DEFAULT '', "
          + "nQty int(16) DEFAULT 1, "
          + "sKeyToParent varchar(64) NOT NULL DEFAULT '', "
          + "sFilter varchar(64) DEFAULT NULL, "
          + "nStr int(16) DEFAULT 0, "
          + "nDex int(16) DEFAULT 0, "
          + "nCon int(16) DEFAULT 0, "
          + "nInt int(16) DEFAULT 0, "
          + "nWis int(16) DEFAULT 0, "
          + "nCha int(16) DEFAULT 0, "
          + "nLevel int(16) DEFAULT 1, "
          + "nGameXP int(16) DEFAULT 0, "
          + "nTradeXP int(16) DEFAULT 0, "
          + "bScalarOverride int(2) DEFAULT 0, "
          + "sAnimation varchar(64) DEFAULT NULL, "
          + "sBiTag varchar(64) DEFAULT NULL, "
          + "nBiQty int(16) DEFAULT 0, "
          + "nOnFailBiQty int(16) DEFAULT 0, "
          + "PRIMARY KEY (sKeyToRecipe))";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    query = "CREATE INDEX sDeviceTag ON cnr_recipes (sDeviceTag)";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    // if cnr_components table does not exist, create it
    query = "CREATE TABLE IF NOT EXISTS cnr_components("
          + "sKeyToComponent varchar(64) NOT NULL DEFAULT '', "
          + "sTag varchar(64) NOT NULL DEFAULT '', "
          + "nQty int(16) DEFAULT 1, "
          + "nRetainQty int(16) DEFAULT 0, "
          + "sKeyToRecipe varchar(64) NOT NULL DEFAULT '', "
          + "sDeviceTag varchar(64) NOT NULL DEFAULT '', "
          + "PRIMARY KEY (sKeyToComponent))";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);

    query = "CREATE INDEX sDeviceTag ON cnr_components (sDeviceTag)";
    sql = SqlPrepareQueryCampaign("db", query);
    sqlstep = SqlStep(sql);
  }

  PrintString("Launching cnr_recipe_init");
  ExecuteScript("cnr_recipe_init", OBJECT_SELF);

  PrintString("Launching cnr_book_init");
  ExecuteScript("cnr_book_init", OBJECT_SELF);

  PrintString("Launching cnr_plant_init");
  ExecuteScript("cnr_plant_init", OBJECT_SELF);

  PrintString("Launching cnr_source_init");
  ExecuteScript("cnr_source_init", OBJECT_SELF);

  PrintString("Launching cnr_merch_init");
  ExecuteScript("cnr_merch_init", OBJECT_SELF);

  PrintString("Launching _createitembag");
  ExecuteScript("_createitembag", OBJECT_SELF);
}
