/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class sdk_model_Smartsheet2 {
    global sdk_model_Smartsheet2() {

    }
global virtual class AccessToken {
    global AccessToken() {

    }
    global String getAccessToken() {
        return null;
    }
    global Integer getExpiresIn() {
        return null;
    }
    global String getRefreshToken() {
        return null;
    }
    global String getTokenType() {
        return null;
    }
    global void setAccessToken(String access_token) {

    }
    global void setExpiresIn(Integer expires_in) {

    }
    global void setRefreshToken(String refresh_token) {

    }
    global void setTokenType(String token_type) {

    }
}
global class Account {
    global Account() {

    }
    global Long getId() {
        return null;
    }
    global String getName() {
        return null;
    }
    global void setId(Long id) {

    }
    global void setName(String name) {

    }
}
global class Cell {
    global Long getColumnId() {
        return null;
    }
    global String getDisplayValue() {
        return null;
    }
    global String getLink() {
        return null;
    }
    global Long getRowId() {
        return null;
    }
    global Boolean getStrict() {
        return null;
    }
    global String getType() {
        return null;
    }
    global String getValue() {
        return null;
    }
    global void setColumnId(Long columnId) {

    }
    global void setDisplayValue(String displayValue) {

    }
    global void setLink(String link) {

    }
    global void setRowId(Long rowId) {

    }
    global void setStrict(Boolean strict) {

    }
    global void setType(String type) {

    }
    global void setValue(String value) {

    }
}
global class Column implements System.Comparable {
    global Column() {

    }
    global Long getId() {
        return null;
    }
    global Integer getIndex() {
        return null;
    }
    global List<String> getOptions() {
        return null;
    }
    global Boolean getPrimary() {
        return null;
    }
    global String getSymbol() {
        return null;
    }
    global String getTitle() {
        return null;
    }
    global String getType() {
        return null;
    }
    global void setId(Long id) {

    }
    global void setIndex(Integer index) {

    }
    global void setOptions(List<String> options) {

    }
    global void setPrimary(Boolean primary) {

    }
    global void setSymbol(String symbol) {

    }
    global void setTitle(String title) {

    }
    global void setType(String type) {

    }
}
global class ColumnDataResult extends com_smartsheet.sdk_model_Smartsheet2.DataWrapper {
    global ColumnDataResult() {

    }
}
global class ColumnResult extends com_smartsheet.sdk_model_Smartsheet2.resultObject {
    global ColumnResult() {

    }
}
global virtual class DataWrapper {
    global DataWrapper() {

    }
}
global class Folder implements System.Comparable {
    global Folder() {

    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Folder> getFolders() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getName() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Sheet> getSheets() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Template> getTemplates() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Workspace> getWorkspaces() {
        return null;
    }
    global void setFolders(List<com_smartsheet.sdk_model_Smartsheet2.Folder> folders) {

    }
    global void setId(Long id) {

    }
    global void setName(String name) {

    }
    global void setSheets(List<com_smartsheet.sdk_model_Smartsheet2.Sheet> sheets) {

    }
    global void setTemplates(List<com_smartsheet.sdk_model_Smartsheet2.Template> templates) {

    }
    global void setWorkspaces(List<com_smartsheet.sdk_model_Smartsheet2.Workspace> workspaces) {

    }
}
global class Home {
    global Home() {

    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Folder> getFolders() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Sheet> getSheets() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Template> getTemplates() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Workspace> getWorkspaces() {
        return null;
    }
    global void setFolders(List<com_smartsheet.sdk_model_Smartsheet2.Folder> folders) {

    }
    global void setSheets(List<com_smartsheet.sdk_model_Smartsheet2.Sheet> sheets) {

    }
    global void setTemplates(List<com_smartsheet.sdk_model_Smartsheet2.Template> templates) {

    }
    global void setWorkspaces(List<com_smartsheet.sdk_model_Smartsheet2.Workspace> workspaces) {

    }
}
global class InsertRows {
    global InsertRows() {

    }
}
global class RestError {
    global RestError() {

    }
    global String getError() {
        return null;
    }
    global Integer getErrorCode() {
        return null;
    }
    global String getMessage() {
        return null;
    }
    global void setError(String error) {

    }
    global void setErrorCode(Integer errorCode) {

    }
    global void setMessage(String message) {

    }
}
global class Row {
    global Row() {

    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Cell> getCells() {
        return null;
    }
    global String getCreatedAt() {
        return null;
    }
    global Boolean getExpanded() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getModifiedAt() {
        return null;
    }
    global Long getParentId() {
        return null;
    }
    global Long getRowNumber() {
        return null;
    }
    global Long getSheetId() {
        return null;
    }
    global Long getSiblingId() {
        return null;
    }
    global Boolean getToBottom() {
        return null;
    }
    global Boolean getToTop() {
        return null;
    }
    global Long getVersion() {
        return null;
    }
    global void setCells(List<com_smartsheet.sdk_model_Smartsheet2.Cell> cells) {

    }
    global void setCreatedAt(String createdAt) {

    }
    global void setExpanded(Boolean expanded) {

    }
    global void setId(Long id) {

    }
    global void setModifiedAt(String modifiedAt) {

    }
    global void setParentId(Long parentId) {

    }
    global void setRowNumber(Long rowNumber) {

    }
    global void setSheetId(Long sheetId) {

    }
    global void setSiblingId(Long siblingId) {

    }
    global void setToBottom(Boolean toBottom) {

    }
    global void setToTop(Boolean toTop) {

    }
    global void setVersion(Long version) {

    }
}
global class RowsResult extends com_smartsheet.sdk_model_Smartsheet2.resultObject {
    global RowsResult() {

    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Row> getResult() {
        return null;
    }
    global void setResult(List<com_smartsheet.sdk_model_Smartsheet2.Row> result) {

    }
}
global class Sheet implements System.Comparable {
    global Sheet() {

    }
    global Integer compareTo(Object compareTo) {
        return null;
    }
    global String getAccessLevel() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Column> getColumns() {
        return null;
    }
    global String getCreatedAt() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getModifiedAt() {
        return null;
    }
    global String getName() {
        return null;
    }
    global String getPermalink() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Row> getRows() {
        return null;
    }
    global Integer getTotalRowCount() {
        return null;
    }
    global Integer getVersion() {
        return null;
    }
    global void setAccessLevel(String accessLevel) {

    }
    global void setColumns(List<com_smartsheet.sdk_model_Smartsheet2.Column> columns) {

    }
    global void setCreatedAt(String createdAt) {

    }
    global void setId(Long id) {

    }
    global void setModifiedAt(String modifiedAt) {

    }
    global void setName(String name) {

    }
    global void setPermalink(String permalink) {

    }
    global void setRows(List<com_smartsheet.sdk_model_Smartsheet2.Row> rows) {

    }
    global void setTotalRowCount(Integer totalRowCount) {

    }
    global void setVersion(Integer version) {

    }
}
global class SheetResult extends com_smartsheet.sdk_model_Smartsheet2.resultObject {
    global SheetResult() {

    }
    global Long getId() {
        return null;
    }
    global com_smartsheet.sdk_model_Smartsheet2.Sheet getResult() {
        return null;
    }
    global void setId(Long Id) {

    }
    global void setResult(com_smartsheet.sdk_model_Smartsheet2.Sheet result) {

    }
}
global class Template {
    global Template() {

    }
    global String getAccessLevel() {
        return null;
    }
    global String getDescription() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getName() {
        return null;
    }
    global void setAccessLevel(String accessLevel) {

    }
    global void setDescription(String description) {

    }
    global void setId(Long id) {

    }
    global void setName(String name) {

    }
}
global class UpdateCells {
    global UpdateCells() {

    }
}
global class UpdateRow {
    global UpdateRow() {

    }
}
global class UpdateRowResult extends com_smartsheet.sdk_model_Smartsheet2.resultObject {
    global UpdateRowResult() {

    }
}
global class User {
    global User() {

    }
    global com_smartsheet.sdk_model_Smartsheet2.Account getAccount() {
        return null;
    }
    global String getEmail() {
        return null;
    }
    global String getFirstName() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getLastName() {
        return null;
    }
    global String getLocale() {
        return null;
    }
    global String getTimeZone() {
        return null;
    }
    global void setAccount(com_smartsheet.sdk_model_Smartsheet2.Account account) {

    }
    global void setEmail(String email) {

    }
    global void setFirstName(String firstName) {

    }
    global void setId(Long Id) {

    }
    global void setLastName(String lastName) {

    }
    global void setLocale(String locale) {

    }
    global void setTimeZone(String timeZone) {

    }
}
global class Workspace {
    global Workspace() {

    }
    global String getAccessLevel() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Folder> getFolders() {
        return null;
    }
    global Long getId() {
        return null;
    }
    global String getName() {
        return null;
    }
    global String getPermalink() {
        return null;
    }
    global List<com_smartsheet.sdk_model_Smartsheet2.Sheet> getSheets() {
        return null;
    }
    global void setAccessLevel(String accessLevel) {

    }
    global void setFolders(List<com_smartsheet.sdk_model_Smartsheet2.Folder> folders) {

    }
    global void setId(Long id) {

    }
    global void setName(String name) {

    }
    global void setPermalink(String permalink) {

    }
    global void setSheets(List<com_smartsheet.sdk_model_Smartsheet2.Sheet> sheets) {

    }
}
global virtual class resultObject {
    global resultObject() {

    }
}
}
