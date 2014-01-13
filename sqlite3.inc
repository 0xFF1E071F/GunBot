; SQLite include file for MASM32 - 2007.09.20

sqlite3_aggregate_context PROTO C :DWORD,:VARARG
sqlite3_aggregate_count PROTO C :DWORD,:VARARG
sqlite3_apis PROTO C :DWORD,:VARARG
sqlite3_auto_extension PROTO C :DWORD,:VARARG
sqlite3_bind_blob PROTO C :DWORD,:VARARG
sqlite3_bind_double PROTO C :DWORD,:VARARG
sqlite3_bind_int PROTO C :DWORD,:VARARG
sqlite3_bind_int64 PROTO C :DWORD,:VARARG
sqlite3_bind_null PROTO C :DWORD,:VARARG
sqlite3_bind_parameter_count PROTO C :DWORD,:VARARG
sqlite3_bind_parameter_index PROTO C :DWORD,:VARARG
sqlite3_bind_parameter_name PROTO C :DWORD,:VARARG
sqlite3_bind_text PROTO C :DWORD,:VARARG
sqlite3_bind_text16 PROTO C :DWORD,:VARARG
sqlite3_bind_value PROTO C :DWORD,:VARARG
sqlite3_bind_zeroblob PROTO C :DWORD,:VARARG
sqlite3_blob_bytes PROTO C :DWORD,:VARARG
sqlite3_blob_close PROTO C :DWORD,:VARARG
sqlite3_blob_open PROTO C :DWORD,:VARARG
sqlite3_blob_read PROTO C :DWORD,:VARARG
sqlite3_blob_write PROTO C :DWORD,:VARARG
sqlite3_busy_handler PROTO C :DWORD,:VARARG
sqlite3_busy_timeout PROTO C :DWORD,:VARARG
sqlite3_changes PROTO C :DWORD,:VARARG
sqlite3_clear_bindings PROTO C :DWORD,:VARARG
sqlite3_close PROTO C :DWORD,:VARARG
sqlite3_collation_needed PROTO C :DWORD,:VARARG
sqlite3_collation_needed16 PROTO C :DWORD,:VARARG
sqlite3_column_blob PROTO C :DWORD,:VARARG
sqlite3_column_bytes PROTO C :DWORD,:VARARG
sqlite3_column_bytes16 PROTO C :DWORD,:VARARG
sqlite3_column_count PROTO C :DWORD,:VARARG
sqlite3_column_decltype PROTO C :DWORD,:VARARG
sqlite3_column_decltype16 PROTO C :DWORD,:VARARG
sqlite3_column_double PROTO C :DWORD,:VARARG
sqlite3_column_int PROTO C :DWORD,:VARARG
sqlite3_column_int64 PROTO C :DWORD,:VARARG
sqlite3_column_name PROTO C :DWORD,:VARARG
sqlite3_column_name16 PROTO C :DWORD,:VARARG
sqlite3_column_text PROTO C :DWORD,:VARARG
sqlite3_column_text16 PROTO C :DWORD,:VARARG
sqlite3_column_type PROTO C :DWORD,:VARARG
sqlite3_column_value PROTO C :DWORD,:VARARG
sqlite3_commit_hook PROTO C :DWORD,:VARARG
sqlite3_complete PROTO C :DWORD,:VARARG
sqlite3_complete16 PROTO C :DWORD,:VARARG
sqlite3_create_collation PROTO C :DWORD,:VARARG
sqlite3_create_collation16 PROTO C :DWORD,:VARARG
sqlite3_create_collation_v2 PROTO C :DWORD,:VARARG
sqlite3_create_function PROTO C :DWORD,:VARARG
sqlite3_create_function16 PROTO C :DWORD,:VARARG
sqlite3_create_module PROTO C :DWORD,:VARARG
sqlite3_create_module_v2 PROTO C :DWORD,:VARARG
sqlite3_data_count PROTO C :DWORD,:VARARG
sqlite3_db_handle PROTO C :DWORD,:VARARG
sqlite3_declare_vtab PROTO C :DWORD,:VARARG
sqlite3_enable_load_extension PROTO C :DWORD,:VARARG
sqlite3_enable_shared_cache PROTO C :DWORD,:VARARG
sqlite3_errcode PROTO C :DWORD,:VARARG
sqlite3_errmsg PROTO C :DWORD,:VARARG
sqlite3_errmsg16 PROTO C :DWORD,:VARARG
sqlite3_exec PROTO C :DWORD,:VARARG
sqlite3_expired PROTO C :DWORD,:VARARG
sqlite3_extended_result_codes PROTO C :DWORD,:VARARG
sqlite3_finalize PROTO C :DWORD,:VARARG
sqlite3_free PROTO C :DWORD,:VARARG
sqlite3_free_table PROTO C :DWORD,:VARARG
sqlite3_get_autocommit PROTO C :DWORD,:VARARG
sqlite3_get_auxdata PROTO C :DWORD,:VARARG
sqlite3_get_table PROTO C :DWORD,:VARARG
sqlite3_global_recover PROTO C :DWORD,:VARARG
sqlite3_interrupt PROTO C :DWORD,:VARARG
sqlite3_last_insert_rowid PROTO C :DWORD,:VARARG
sqlite3_libversion PROTO C :DWORD,:VARARG
sqlite3_libversion_number PROTO C :DWORD,:VARARG
sqlite3_load_extension PROTO C :DWORD,:VARARG
sqlite3_malloc PROTO C :DWORD,:VARARG
sqlite3_mprintf PROTO C :DWORD,:VARARG
sqlite3_open PROTO C :DWORD,:VARARG
sqlite3_open16 PROTO C :DWORD,:VARARG
sqlite3_overload_function PROTO C :DWORD,:VARARG
sqlite3_prepare PROTO C :DWORD,:VARARG
sqlite3_prepare16 PROTO C :DWORD,:VARARG
sqlite3_prepare16_v2 PROTO C :DWORD,:VARARG
sqlite3_prepare_v2 PROTO C :DWORD,:VARARG
sqlite3_profile PROTO C :DWORD,:VARARG
sqlite3_progress_handler PROTO C :DWORD,:VARARG
sqlite3_realloc PROTO C :DWORD,:VARARG
sqlite3_reset PROTO C :DWORD,:VARARG
sqlite3_reset_auto_extension PROTO C :DWORD,:VARARG
sqlite3_result_blob PROTO C :DWORD,:VARARG
sqlite3_result_double PROTO C :DWORD,:VARARG
sqlite3_result_error PROTO C :DWORD,:VARARG
sqlite3_result_error16 PROTO C :DWORD,:VARARG
sqlite3_result_error_toobig PROTO C :DWORD,:VARARG
sqlite3_result_int PROTO C :DWORD,:VARARG
sqlite3_result_int64 PROTO C :DWORD,:VARARG
sqlite3_result_null PROTO C :DWORD,:VARARG
sqlite3_result_text PROTO C :DWORD,:VARARG
sqlite3_result_text16 PROTO C :DWORD,:VARARG
sqlite3_result_text16be PROTO C :DWORD,:VARARG
sqlite3_result_text16le PROTO C :DWORD,:VARARG
sqlite3_result_value PROTO C :DWORD,:VARARG
sqlite3_result_zeroblob PROTO C :DWORD,:VARARG
sqlite3_rollback_hook PROTO C :DWORD,:VARARG
sqlite3_set_authorizer PROTO C :DWORD,:VARARG
sqlite3_set_auxdata PROTO C :DWORD,:VARARG
sqlite3_sleep PROTO C :DWORD,:VARARG
sqlite3_snprintf PROTO C :DWORD,:VARARG
sqlite3_step PROTO C :DWORD,:VARARG
sqlite3_thread_cleanup PROTO C :DWORD,:VARARG
sqlite3_total_changes PROTO C :DWORD,:VARARG
sqlite3_trace PROTO C :DWORD,:VARARG
sqlite3_transfer_bindings PROTO C :DWORD,:VARARG
sqlite3_update_hook PROTO C :DWORD,:VARARG
sqlite3_user_data PROTO C :DWORD,:VARARG
sqlite3_value_blob PROTO C :DWORD,:VARARG
sqlite3_value_bytes PROTO C :DWORD,:VARARG
sqlite3_value_bytes16 PROTO C :DWORD,:VARARG
sqlite3_value_double PROTO C :DWORD,:VARARG
sqlite3_value_int PROTO C :DWORD,:VARARG
sqlite3_value_int64 PROTO C :DWORD,:VARARG
sqlite3_value_numeric_type PROTO C :DWORD,:VARARG
sqlite3_value_text PROTO C :DWORD,:VARARG
sqlite3_value_text16 PROTO C :DWORD,:VARARG
sqlite3_value_text16be PROTO C :DWORD,:VARARG
sqlite3_value_text16le PROTO C :DWORD,:VARARG
sqlite3_value_type PROTO C :DWORD,:VARARG
sqlite3_version PROTO C :DWORD,:VARARG
sqlite3_vmprintf PROTO C :DWORD,:VARARG


SQLITE_INTEGER    equ    1   ; data types
SQLITE_FLOAT      equ    2
SQLITE_TEXT       equ    3
SQLITE3_TEXT      equ    3
SQLITE_BLOB       equ    4
SQLITE_NULL       equ    5

SQLITE_OK         equ    0   ; /* Successful result */
SQLITE_ERROR      equ    1   ; /* SQL error or missing database */
SQLITE_INTERNAL   equ    2   ; /* NOT USED. Internal logic error in SQLite */
SQLITE_PERM       equ    3   ; /* Access permission denied */
SQLITE_ABORT      equ    4   ; /* Callback routine requested an abort */
SQLITE_BUSY       equ    5   ; /* The database file is locked */
SQLITE_LOCKED     equ    6   ; /* A table in the database is locked */
SQLITE_NOMEM      equ    7   ; /* A malloc() failed */
SQLITE_READONLY   equ    8   ; /* Attempt to write a readonly database */
SQLITE_INTERRUPT  equ    9   ; /* Operation terminated by sqlite3_interrupt()*/
SQLITE_IOERR      equ   10   ; /* Some kind of disk I/O error occurred */
SQLITE_IOERR_READ       equ (10 or (1*256)) ; (SQLITE_IOERR | (1<<8))
SQLITE_IOERR_SHORT_READ equ (10 or (2*256))
SQLITE_IOERR_WRITE      equ (10 or (3*256))
SQLITE_IOERR_FSYNC      equ (10 or (4*256))
SQLITE_IOERR_DIR_FSYNC  equ (10 or (5*256))
SQLITE_IOERR_TRUNCATE   equ (10 or (6*256))
SQLITE_IOERR_FSTAT      equ (10 or (7*256))
SQLITE_IOERR_UNLOCK     equ (10 or (8*256))
SQLITE_IOERR_RDLOCK     equ (10 or (9*256))
SQLITE_IOERR_DELETE     equ (10 or (10*256))
SQLITE_IOERR_BLOCKED    equ (10 or (11*256))
SQLITE_CORRUPT    equ   11   ; /* The database disk image is malformed */
SQLITE_NOTFOUND   equ   12   ; /* NOT USED. Table or record not found */
SQLITE_FULL       equ   13   ; /* Insertion failed because database is full */
SQLITE_CANTOPEN   equ   14   ; /* Unable to open the database file */
SQLITE_PROTOCOL   equ   15   ; /* NOT USED. Database lock protocol error */
SQLITE_EMPTY      equ   16   ; /* Database is empty */
SQLITE_SCHEMA     equ   17   ; /* The database schema changed */
SQLITE_TOOBIG     equ   18   ; /* String or BLOB exceeds size limit */
SQLITE_CONSTRAINT equ   19   ; /* Abort due to contraint violation */
SQLITE_MISMATCH   equ   20   ; /* Data type mismatch */
SQLITE_MISUSE     equ   21   ; /* Library used incorrectly */
SQLITE_NOLFS      equ   22   ; /* Uses OS features not supported on host */
SQLITE_AUTH       equ   23   ; /* Authorization denied */
SQLITE_FORMAT     equ   24   ; /* Auxiliary database format error */
SQLITE_RANGE      equ   25   ; /* 2nd parameter to sqlite3_bind out of range */
SQLITE_NOTADB     equ   26   ; /* File opened that is not a database file */
SQLITE_ROW        equ   100  ; /* sqlite3_step() has another row ready */
SQLITE_DONE       equ   101  ; /* sqlite3_step() has finished executing */

SQLITE_COPY                equ  0  ; /* Table Name      File Name       */
SQLITE_CREATE_INDEX        equ  1  ; /* Index Name      Table Name      */
SQLITE_CREATE_TABLE        equ  2  ; /* Table Name      NULL            */
SQLITE_CREATE_TEMP_INDEX   equ  3  ; /* Index Name      Table Name      */
SQLITE_CREATE_TEMP_TABLE   equ  4  ; /* Table Name      NULL            */
SQLITE_CREATE_TEMP_TRIGGER equ  5  ; /* Trigger Name    Table Name      */
SQLITE_CREATE_TEMP_VIEW    equ  6  ; /* View Name       NULL            */
SQLITE_CREATE_TRIGGER      equ  7  ; /* Trigger Name    Table Name      */
SQLITE_CREATE_VIEW         equ  8  ; /* View Name       NULL            */
SQLITE_DELETE              equ  9  ; /* Table Name      NULL            */
SQLITE_DROP_INDEX          equ 10  ; /* Index Name      Table Name      */
SQLITE_DROP_TABLE          equ 11  ; /* Table Name      NULL            */
SQLITE_DROP_TEMP_INDEX     equ 12  ; /* Index Name      Table Name      */
SQLITE_DROP_TEMP_TABLE     equ 13  ; /* Table Name      NULL            */
SQLITE_DROP_TEMP_TRIGGER   equ 14  ; /* Trigger Name    Table Name      */
SQLITE_DROP_TEMP_VIEW      equ 15  ; /* View Name       NULL            */
SQLITE_DROP_TRIGGER        equ 16  ; /* Trigger Name    Table Name      */
SQLITE_DROP_VIEW           equ 17  ; /* View Name       NULL            */
SQLITE_INSERT              equ 18  ; /* Table Name      NULL            */
SQLITE_PRAGMA              equ 19  ; /* Pragma Name     1st arg or NULL */
SQLITE_READ                equ 20  ; /* Table Name      Column Name     */
SQLITE_SELECT              equ 21  ; /* NULL            NULL            */
SQLITE_TRANSACTION         equ 22  ; /* NULL            NULL            */
SQLITE_UPDATE              equ 23  ; /* Table Name      Column Name     */
SQLITE_ATTACH              equ 24  ; /* Filename        NULL            */
SQLITE_DETACH              equ 25  ; /* Database Name   NULL            */
SQLITE_ALTER_TABLE         equ 26  ; /* Database Name   Table Name      */
SQLITE_REINDEX             equ 27  ; /* Index Name      NULL            */
SQLITE_ANALYZE             equ 28  ; /* Table Name      NULL            */
SQLITE_CREATE_VTABLE       equ 29  ; /* Table Name      Module Name     */
SQLITE_DROP_VTABLE         equ 30  ; /* Table Name      Module Name     */
SQLITE_FUNCTION            equ 31  ; /* Function Name   NULL            */
SQLITE_COPY                equ  0  ; /* No longer used */

SQLITE_DENY       equ   1   ; /* Abort the SQL statement with an error */
SQLITE_IGNORE     equ   2   ; /* Don't allow access, but don't generate an error */

SQLITE_UTF8           equ 1    ; supported text encodings
SQLITE_UTF16LE        equ 2
SQLITE_UTF16BE        equ 3
SQLITE_UTF16          equ 4    ; /* Use native byte order */
SQLITE_ANY            equ 5    ; /* sqlite3_create_function only */
SQLITE_UTF16_ALIGNED  equ 8    ; /* sqlite3_create_collation only */



;struct sqlite3_index_info {
;  /* Inputs */
;  const int nConstraint;     /* Number of entries in aConstraint */
;  const struct sqlite3_index_constraint {
;     int iColumn;              /* Column on left-hand side of constraint */
;     unsigned char op;         /* Constraint operator */
;     unsigned char usable;     /* True if this constraint is usable */
;     int iTermOffset;          /* Used internally - xBestIndex should ignore */
;  } *const aConstraint;      /* Table of WHERE clause constraints */
;  const int nOrderBy;        /* Number of terms in the ORDER BY clause */
;  const struct sqlite3_index_orderby {
;     int iColumn;              /* Column number */
;     unsigned char desc;       /* True for DESC.  False for ASC. */
;  } *const aOrderBy;         /* The ORDER BY clause */
;
;  /* Outputs */
;  struct sqlite3_index_constraint_usage {
;    int argvIndex;           /* if >0, constraint is part of argv to xFilter */
;    unsigned char omit;      /* Do not code a test for this constraint */
;  } *const aConstraintUsage;
;  int idxNum;                /* Number used to identify the index */
;  char *idxStr;              /* String, possibly obtained from sqlite3_malloc */
;  int needToFreeIdxStr;      /* Free idxStr using sqlite3_free() if true */
;  int orderByConsumed;       /* True if output is already ordered */
;  double estimatedCost;      /* Estimated cost of using this index */
;};

    sqlite3_index_constraint struct 
        iColumnl dd ?        ;/* Column on left-hand side of constraint */
        op      dd ?        ;/* Constraint operator */
        usable  dd ?        ;/* True if this constraint is usable */
        iTermOffset dd ?    ;/* Used internally - xBestIndex should ignore */
    sqlite3_index_constraint ends

    sqlite3_index_orderby struct 
        iColumn dd ?        ;/* Column number */
        desc dd ?           ;/* True for DESC.  False for ASC. */
    sqlite3_index_orderby ends

    sqlite3_index_constraint_usage struct 
        argvIndex dd ?      ;/* if >0, constraint is part of argv to xFilter */
        omit dd ?           ;/* Do not code a test for this constraint */
    sqlite3_index_constraint_usage ends


sqlite3_index_info struct 
    nConstraint dd ?        ;/* Number of entries in aConstraint */
    sqlite3_index_constraint <>
    nOrderBy dd ?           ;/* Number of terms in the ORDER BY clause */
    sqlite3_index_orderby <>
    sqlite3_index_constraint_usage <>
    idxNum dd ?             ;/* Number used to identify the index */
    idxStr dd ?             ;/* String, possibly obtained from sqlite3_malloc */
    needToFreeIdxStr dd ?   ;/* Free idxStr using sqlite3_free() if true */
    orderByConsumed dd ?    ;/* True if output is already ordered */
    estimatedCost dq ?      ;/* Estimated cost of using this index */
sqlite3_index_info ends

SQLITE_INDEX_CONSTRAINT_EQ    equ  2
SQLITE_INDEX_CONSTRAINT_GT    equ  4
SQLITE_INDEX_CONSTRAINT_LE    equ  8
SQLITE_INDEX_CONSTRAINT_LT    equ 16
SQLITE_INDEX_CONSTRAINT_GE    equ 32
SQLITE_INDEX_CONSTRAINT_MATCH equ 64

SQLITE_STATIC    equ 0
SQLITE_TRANSIENT equ -1


sqlite3_module struct 
    iVersion        dd ?
    xCreate         dd ? ; (sqlite3*,pAux,argc,argv,ppVTab,char*)
    xConnect        dd ? ; (sqlite3*,pAux,argc,argv,ppVTab,char*)
    xBestIndex      dd ? ; (pVTab,sqlite3_index_info*)
    xDisconnect     dd ? ; (pVTab)
    xDestroy        dd ? ; (pVTab)
    xOpen           dd ? ; (pVTab,ppCursor)
    xClose          dd ? ; (sqlite3_vtab_cursor*)
    xFilter         dd ? ; (sqlite3_vtab_cursor*,idxNum,idxStr,argc,argv)
    xNext           dd ? ; (sqlite3_vtab_cursor*)
    xEof            dd ? ; (sqlite3_vtab_cursor*)
    xColumn         dd ? ; (sqlite3_vtab_cursor*,sqlite3_context*,int)
    xRowid          dd ? ; (sqlite3_vtab_cursor*,pRowid)
    xUpdate         dd ? ; (sqlite3_vtab*,int,sqlite3_value*,sqlite_int64*)
    xBegin          dd ? ; (pVTab)
    xSync           dd ? ; (pVTab)
    xCommit         dd ? ; (pVTab)
    xRollback       dd ? ; (pVTab)
    xFindFunction   dd ? ; (pVtab,nArg,zName,pxFunc,ppArg)
    xRename         dd ? ; (pVtab,zNew)
    ;xRename         dd ? ; (pVtab,zNew)
sqlite3_module ends


