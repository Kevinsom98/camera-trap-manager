// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// ignore_for_file: type=lint
class $ProjectFoldersTable extends ProjectFolders with TableInfo<$ProjectFoldersTable, ProjectFolder>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$ProjectFoldersTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _nameMeta = const VerificationMeta('name');
@override
late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false, additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1,maxTextLength: 255), type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateCreatedMeta = const VerificationMeta('dateCreated');
@override
late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>('date_created', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, uuid, name, dateCreated];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'project_folders';
@override
VerificationContext validateIntegrity(Insertable<ProjectFolder> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('name')) {
context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));} else if (isInserting) {
context.missing(_nameMeta);
}
if (data.containsKey('date_created')) {
context.handle(_dateCreatedMeta, dateCreated.isAcceptableOrUnknown(data['date_created']!, _dateCreatedMeta));} else if (isInserting) {
context.missing(_dateCreatedMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override ProjectFolder map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return ProjectFolder(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!, dateCreated: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!, );
}
@override
$ProjectFoldersTable createAlias(String alias) {
return $ProjectFoldersTable(attachedDatabase, alias);}}class ProjectFolder extends DataClass implements Insertable<ProjectFolder> 
{
final int id;
final String uuid;
final String name;
final DateTime dateCreated;
const ProjectFolder({required this.id, required this.uuid, required this.name, required this.dateCreated});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['name'] = Variable<String>(name);
map['date_created'] = Variable<DateTime>(dateCreated);
return map; 
}
ProjectFoldersCompanion toCompanion(bool nullToAbsent) {
return ProjectFoldersCompanion(id: Value(id),uuid: Value(uuid),name: Value(name),dateCreated: Value(dateCreated),);
}
factory ProjectFolder.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return ProjectFolder(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),name: serializer.fromJson<String>(json['name']),dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'name': serializer.toJson<String>(name),'dateCreated': serializer.toJson<DateTime>(dateCreated),};}ProjectFolder copyWith({int? id,String? uuid,String? name,DateTime? dateCreated}) => ProjectFolder(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,dateCreated: dateCreated ?? this.dateCreated,);ProjectFolder copyWithCompanion(ProjectFoldersCompanion data) {
return ProjectFolder(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,name: data.name.present ? data.name.value : this.name,dateCreated: data.dateCreated.present ? data.dateCreated.value : this.dateCreated,);
}
@override
String toString() {return (StringBuffer('ProjectFolder(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('dateCreated: $dateCreated')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, name, dateCreated);@override
bool operator ==(Object other) => identical(this, other) || (other is ProjectFolder && other.id == this.id && other.uuid == this.uuid && other.name == this.name && other.dateCreated == this.dateCreated);
}class ProjectFoldersCompanion extends UpdateCompanion<ProjectFolder> {
final Value<int> id;
final Value<String> uuid;
final Value<String> name;
final Value<DateTime> dateCreated;
const ProjectFoldersCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.name = const Value.absent(),this.dateCreated = const Value.absent(),});
ProjectFoldersCompanion.insert({this.id = const Value.absent(),required String uuid,required String name,required DateTime dateCreated,}): uuid = Value(uuid), name = Value(name), dateCreated = Value(dateCreated);
static Insertable<ProjectFolder> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<String>? name, 
Expression<DateTime>? dateCreated, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (name != null)'name': name,if (dateCreated != null)'date_created': dateCreated,});
}ProjectFoldersCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<String>? name, Value<DateTime>? dateCreated}) {
return ProjectFoldersCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,name: name ?? this.name,dateCreated: dateCreated ?? this.dateCreated,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (name.present) {
map['name'] = Variable<String>(name.value);}
if (dateCreated.present) {
map['date_created'] = Variable<DateTime>(dateCreated.value);}
return map; 
}
@override
String toString() {return (StringBuffer('ProjectFoldersCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('name: $name, ')..write('dateCreated: $dateCreated')..write(')')).toString();}
}
class $CameraTrapsTable extends CameraTraps with TableInfo<$CameraTrapsTable, CameraTrap>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$CameraTrapsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
@override
late final GeneratedColumn<String> uuid = GeneratedColumn<String>('uuid', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _projectIdMeta = const VerificationMeta('projectId');
@override
late final GeneratedColumn<int> projectId = GeneratedColumn<int>('project_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES project_folders (id) ON DELETE CASCADE'));
static const VerificationMeta _trapNameMeta = const VerificationMeta('trapName');
@override
late final GeneratedColumn<String> trapName = GeneratedColumn<String>('trap_name', aliasedName, false, additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1,maxTextLength: 255), type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
@override
late final GeneratedColumn<double> latitude = GeneratedColumn<double>('latitude', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
@override
late final GeneratedColumn<double> longitude = GeneratedColumn<double>('longitude', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _gpsAccuracyMeta = const VerificationMeta('gpsAccuracy');
@override
late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>('gps_accuracy', aliasedName, false, type: DriftSqlType.double, requiredDuringInsert: true);
static const VerificationMeta _deployedByMeta = const VerificationMeta('deployedBy');
@override
late final GeneratedColumn<String> deployedBy = GeneratedColumn<String>('deployed_by', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _compassDirectionMeta = const VerificationMeta('compassDirection');
@override
late final GeneratedColumn<String> compassDirection = GeneratedColumn<String>('compass_direction', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateTimeDeployedMeta = const VerificationMeta('dateTimeDeployed');
@override
late final GeneratedColumn<DateTime> dateTimeDeployed = GeneratedColumn<DateTime>('date_time_deployed', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _envConditionsMeta = const VerificationMeta('envConditions');
@override
late final GeneratedColumn<String> envConditions = GeneratedColumn<String>('env_conditions', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, uuid, projectId, trapName, latitude, longitude, gpsAccuracy, deployedBy, compassDirection, dateTimeDeployed, envConditions];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'camera_traps';
@override
VerificationContext validateIntegrity(Insertable<CameraTrap> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('uuid')) {
context.handle(_uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));} else if (isInserting) {
context.missing(_uuidMeta);
}
if (data.containsKey('project_id')) {
context.handle(_projectIdMeta, projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));} else if (isInserting) {
context.missing(_projectIdMeta);
}
if (data.containsKey('trap_name')) {
context.handle(_trapNameMeta, trapName.isAcceptableOrUnknown(data['trap_name']!, _trapNameMeta));} else if (isInserting) {
context.missing(_trapNameMeta);
}
if (data.containsKey('latitude')) {
context.handle(_latitudeMeta, latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));} else if (isInserting) {
context.missing(_latitudeMeta);
}
if (data.containsKey('longitude')) {
context.handle(_longitudeMeta, longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));} else if (isInserting) {
context.missing(_longitudeMeta);
}
if (data.containsKey('gps_accuracy')) {
context.handle(_gpsAccuracyMeta, gpsAccuracy.isAcceptableOrUnknown(data['gps_accuracy']!, _gpsAccuracyMeta));} else if (isInserting) {
context.missing(_gpsAccuracyMeta);
}
if (data.containsKey('deployed_by')) {
context.handle(_deployedByMeta, deployedBy.isAcceptableOrUnknown(data['deployed_by']!, _deployedByMeta));} else if (isInserting) {
context.missing(_deployedByMeta);
}
if (data.containsKey('compass_direction')) {
context.handle(_compassDirectionMeta, compassDirection.isAcceptableOrUnknown(data['compass_direction']!, _compassDirectionMeta));} else if (isInserting) {
context.missing(_compassDirectionMeta);
}
if (data.containsKey('date_time_deployed')) {
context.handle(_dateTimeDeployedMeta, dateTimeDeployed.isAcceptableOrUnknown(data['date_time_deployed']!, _dateTimeDeployedMeta));} else if (isInserting) {
context.missing(_dateTimeDeployedMeta);
}
if (data.containsKey('env_conditions')) {
context.handle(_envConditionsMeta, envConditions.isAcceptableOrUnknown(data['env_conditions']!, _envConditionsMeta));} else if (isInserting) {
context.missing(_envConditionsMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override CameraTrap map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return CameraTrap(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, uuid: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}uuid'])!, projectId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}project_id'])!, trapName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}trap_name'])!, latitude: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}latitude'])!, longitude: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}longitude'])!, gpsAccuracy: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}gps_accuracy'])!, deployedBy: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}deployed_by'])!, compassDirection: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}compass_direction'])!, dateTimeDeployed: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date_time_deployed'])!, envConditions: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}env_conditions'])!, );
}
@override
$CameraTrapsTable createAlias(String alias) {
return $CameraTrapsTable(attachedDatabase, alias);}}class CameraTrap extends DataClass implements Insertable<CameraTrap> 
{
final int id;
final String uuid;
final int projectId;
final String trapName;
final double latitude;
final double longitude;
final double gpsAccuracy;
final String deployedBy;
final String compassDirection;
final DateTime dateTimeDeployed;
final String envConditions;
const CameraTrap({required this.id, required this.uuid, required this.projectId, required this.trapName, required this.latitude, required this.longitude, required this.gpsAccuracy, required this.deployedBy, required this.compassDirection, required this.dateTimeDeployed, required this.envConditions});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['uuid'] = Variable<String>(uuid);
map['project_id'] = Variable<int>(projectId);
map['trap_name'] = Variable<String>(trapName);
map['latitude'] = Variable<double>(latitude);
map['longitude'] = Variable<double>(longitude);
map['gps_accuracy'] = Variable<double>(gpsAccuracy);
map['deployed_by'] = Variable<String>(deployedBy);
map['compass_direction'] = Variable<String>(compassDirection);
map['date_time_deployed'] = Variable<DateTime>(dateTimeDeployed);
map['env_conditions'] = Variable<String>(envConditions);
return map; 
}
CameraTrapsCompanion toCompanion(bool nullToAbsent) {
return CameraTrapsCompanion(id: Value(id),uuid: Value(uuid),projectId: Value(projectId),trapName: Value(trapName),latitude: Value(latitude),longitude: Value(longitude),gpsAccuracy: Value(gpsAccuracy),deployedBy: Value(deployedBy),compassDirection: Value(compassDirection),dateTimeDeployed: Value(dateTimeDeployed),envConditions: Value(envConditions),);
}
factory CameraTrap.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return CameraTrap(id: serializer.fromJson<int>(json['id']),uuid: serializer.fromJson<String>(json['uuid']),projectId: serializer.fromJson<int>(json['projectId']),trapName: serializer.fromJson<String>(json['trapName']),latitude: serializer.fromJson<double>(json['latitude']),longitude: serializer.fromJson<double>(json['longitude']),gpsAccuracy: serializer.fromJson<double>(json['gpsAccuracy']),deployedBy: serializer.fromJson<String>(json['deployedBy']),compassDirection: serializer.fromJson<String>(json['compassDirection']),dateTimeDeployed: serializer.fromJson<DateTime>(json['dateTimeDeployed']),envConditions: serializer.fromJson<String>(json['envConditions']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'uuid': serializer.toJson<String>(uuid),'projectId': serializer.toJson<int>(projectId),'trapName': serializer.toJson<String>(trapName),'latitude': serializer.toJson<double>(latitude),'longitude': serializer.toJson<double>(longitude),'gpsAccuracy': serializer.toJson<double>(gpsAccuracy),'deployedBy': serializer.toJson<String>(deployedBy),'compassDirection': serializer.toJson<String>(compassDirection),'dateTimeDeployed': serializer.toJson<DateTime>(dateTimeDeployed),'envConditions': serializer.toJson<String>(envConditions),};}CameraTrap copyWith({int? id,String? uuid,int? projectId,String? trapName,double? latitude,double? longitude,double? gpsAccuracy,String? deployedBy,String? compassDirection,DateTime? dateTimeDeployed,String? envConditions}) => CameraTrap(id: id ?? this.id,uuid: uuid ?? this.uuid,projectId: projectId ?? this.projectId,trapName: trapName ?? this.trapName,latitude: latitude ?? this.latitude,longitude: longitude ?? this.longitude,gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,deployedBy: deployedBy ?? this.deployedBy,compassDirection: compassDirection ?? this.compassDirection,dateTimeDeployed: dateTimeDeployed ?? this.dateTimeDeployed,envConditions: envConditions ?? this.envConditions,);CameraTrap copyWithCompanion(CameraTrapsCompanion data) {
return CameraTrap(
id: data.id.present ? data.id.value : this.id,uuid: data.uuid.present ? data.uuid.value : this.uuid,projectId: data.projectId.present ? data.projectId.value : this.projectId,trapName: data.trapName.present ? data.trapName.value : this.trapName,latitude: data.latitude.present ? data.latitude.value : this.latitude,longitude: data.longitude.present ? data.longitude.value : this.longitude,gpsAccuracy: data.gpsAccuracy.present ? data.gpsAccuracy.value : this.gpsAccuracy,deployedBy: data.deployedBy.present ? data.deployedBy.value : this.deployedBy,compassDirection: data.compassDirection.present ? data.compassDirection.value : this.compassDirection,dateTimeDeployed: data.dateTimeDeployed.present ? data.dateTimeDeployed.value : this.dateTimeDeployed,envConditions: data.envConditions.present ? data.envConditions.value : this.envConditions,);
}
@override
String toString() {return (StringBuffer('CameraTrap(')..write('id: $id, ')..write('uuid: $uuid, ')..write('projectId: $projectId, ')..write('trapName: $trapName, ')..write('latitude: $latitude, ')..write('longitude: $longitude, ')..write('gpsAccuracy: $gpsAccuracy, ')..write('deployedBy: $deployedBy, ')..write('compassDirection: $compassDirection, ')..write('dateTimeDeployed: $dateTimeDeployed, ')..write('envConditions: $envConditions')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, uuid, projectId, trapName, latitude, longitude, gpsAccuracy, deployedBy, compassDirection, dateTimeDeployed, envConditions);@override
bool operator ==(Object other) => identical(this, other) || (other is CameraTrap && other.id == this.id && other.uuid == this.uuid && other.projectId == this.projectId && other.trapName == this.trapName && other.latitude == this.latitude && other.longitude == this.longitude && other.gpsAccuracy == this.gpsAccuracy && other.deployedBy == this.deployedBy && other.compassDirection == this.compassDirection && other.dateTimeDeployed == this.dateTimeDeployed && other.envConditions == this.envConditions);
}class CameraTrapsCompanion extends UpdateCompanion<CameraTrap> {
final Value<int> id;
final Value<String> uuid;
final Value<int> projectId;
final Value<String> trapName;
final Value<double> latitude;
final Value<double> longitude;
final Value<double> gpsAccuracy;
final Value<String> deployedBy;
final Value<String> compassDirection;
final Value<DateTime> dateTimeDeployed;
final Value<String> envConditions;
const CameraTrapsCompanion({this.id = const Value.absent(),this.uuid = const Value.absent(),this.projectId = const Value.absent(),this.trapName = const Value.absent(),this.latitude = const Value.absent(),this.longitude = const Value.absent(),this.gpsAccuracy = const Value.absent(),this.deployedBy = const Value.absent(),this.compassDirection = const Value.absent(),this.dateTimeDeployed = const Value.absent(),this.envConditions = const Value.absent(),});
CameraTrapsCompanion.insert({this.id = const Value.absent(),required String uuid,required int projectId,required String trapName,required double latitude,required double longitude,required double gpsAccuracy,required String deployedBy,required String compassDirection,required DateTime dateTimeDeployed,required String envConditions,}): uuid = Value(uuid), projectId = Value(projectId), trapName = Value(trapName), latitude = Value(latitude), longitude = Value(longitude), gpsAccuracy = Value(gpsAccuracy), deployedBy = Value(deployedBy), compassDirection = Value(compassDirection), dateTimeDeployed = Value(dateTimeDeployed), envConditions = Value(envConditions);
static Insertable<CameraTrap> custom({Expression<int>? id, 
Expression<String>? uuid, 
Expression<int>? projectId, 
Expression<String>? trapName, 
Expression<double>? latitude, 
Expression<double>? longitude, 
Expression<double>? gpsAccuracy, 
Expression<String>? deployedBy, 
Expression<String>? compassDirection, 
Expression<DateTime>? dateTimeDeployed, 
Expression<String>? envConditions, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (uuid != null)'uuid': uuid,if (projectId != null)'project_id': projectId,if (trapName != null)'trap_name': trapName,if (latitude != null)'latitude': latitude,if (longitude != null)'longitude': longitude,if (gpsAccuracy != null)'gps_accuracy': gpsAccuracy,if (deployedBy != null)'deployed_by': deployedBy,if (compassDirection != null)'compass_direction': compassDirection,if (dateTimeDeployed != null)'date_time_deployed': dateTimeDeployed,if (envConditions != null)'env_conditions': envConditions,});
}CameraTrapsCompanion copyWith({Value<int>? id, Value<String>? uuid, Value<int>? projectId, Value<String>? trapName, Value<double>? latitude, Value<double>? longitude, Value<double>? gpsAccuracy, Value<String>? deployedBy, Value<String>? compassDirection, Value<DateTime>? dateTimeDeployed, Value<String>? envConditions}) {
return CameraTrapsCompanion(id: id ?? this.id,uuid: uuid ?? this.uuid,projectId: projectId ?? this.projectId,trapName: trapName ?? this.trapName,latitude: latitude ?? this.latitude,longitude: longitude ?? this.longitude,gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,deployedBy: deployedBy ?? this.deployedBy,compassDirection: compassDirection ?? this.compassDirection,dateTimeDeployed: dateTimeDeployed ?? this.dateTimeDeployed,envConditions: envConditions ?? this.envConditions,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (uuid.present) {
map['uuid'] = Variable<String>(uuid.value);}
if (projectId.present) {
map['project_id'] = Variable<int>(projectId.value);}
if (trapName.present) {
map['trap_name'] = Variable<String>(trapName.value);}
if (latitude.present) {
map['latitude'] = Variable<double>(latitude.value);}
if (longitude.present) {
map['longitude'] = Variable<double>(longitude.value);}
if (gpsAccuracy.present) {
map['gps_accuracy'] = Variable<double>(gpsAccuracy.value);}
if (deployedBy.present) {
map['deployed_by'] = Variable<String>(deployedBy.value);}
if (compassDirection.present) {
map['compass_direction'] = Variable<String>(compassDirection.value);}
if (dateTimeDeployed.present) {
map['date_time_deployed'] = Variable<DateTime>(dateTimeDeployed.value);}
if (envConditions.present) {
map['env_conditions'] = Variable<String>(envConditions.value);}
return map; 
}
@override
String toString() {return (StringBuffer('CameraTrapsCompanion(')..write('id: $id, ')..write('uuid: $uuid, ')..write('projectId: $projectId, ')..write('trapName: $trapName, ')..write('latitude: $latitude, ')..write('longitude: $longitude, ')..write('gpsAccuracy: $gpsAccuracy, ')..write('deployedBy: $deployedBy, ')..write('compassDirection: $compassDirection, ')..write('dateTimeDeployed: $dateTimeDeployed, ')..write('envConditions: $envConditions')..write(')')).toString();}
}
class $TrapPhotosTable extends TrapPhotos with TableInfo<$TrapPhotosTable, TrapPhoto>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$TrapPhotosTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = const VerificationMeta('id');
@override
late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false, hasAutoIncrement: true, type: DriftSqlType.int, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
static const VerificationMeta _cameraTrapIdMeta = const VerificationMeta('cameraTrapId');
@override
late final GeneratedColumn<int> cameraTrapId = GeneratedColumn<int>('camera_trap_id', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES camera_traps (id) ON DELETE CASCADE'));
static const VerificationMeta _localFilePathMeta = const VerificationMeta('localFilePath');
@override
late final GeneratedColumn<String> localFilePath = GeneratedColumn<String>('local_file_path', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateTakenMeta = const VerificationMeta('dateTaken');
@override
late final GeneratedColumn<DateTime> dateTaken = GeneratedColumn<DateTime>('date_taken', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
@override
List<GeneratedColumn> get $columns => [id, cameraTrapId, localFilePath, dateTaken];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'trap_photos';
@override
VerificationContext validateIntegrity(Insertable<TrapPhoto> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));}if (data.containsKey('camera_trap_id')) {
context.handle(_cameraTrapIdMeta, cameraTrapId.isAcceptableOrUnknown(data['camera_trap_id']!, _cameraTrapIdMeta));} else if (isInserting) {
context.missing(_cameraTrapIdMeta);
}
if (data.containsKey('local_file_path')) {
context.handle(_localFilePathMeta, localFilePath.isAcceptableOrUnknown(data['local_file_path']!, _localFilePathMeta));} else if (isInserting) {
context.missing(_localFilePathMeta);
}
if (data.containsKey('date_taken')) {
context.handle(_dateTakenMeta, dateTaken.isAcceptableOrUnknown(data['date_taken']!, _dateTakenMeta));} else if (isInserting) {
context.missing(_dateTakenMeta);
}
return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override TrapPhoto map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return TrapPhoto(id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!, cameraTrapId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}camera_trap_id'])!, localFilePath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}local_file_path'])!, dateTaken: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date_taken'])!, );
}
@override
$TrapPhotosTable createAlias(String alias) {
return $TrapPhotosTable(attachedDatabase, alias);}}class TrapPhoto extends DataClass implements Insertable<TrapPhoto> 
{
final int id;
final int cameraTrapId;
final String localFilePath;
final DateTime dateTaken;
const TrapPhoto({required this.id, required this.cameraTrapId, required this.localFilePath, required this.dateTaken});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<int>(id);
map['camera_trap_id'] = Variable<int>(cameraTrapId);
map['local_file_path'] = Variable<String>(localFilePath);
map['date_taken'] = Variable<DateTime>(dateTaken);
return map; 
}
TrapPhotosCompanion toCompanion(bool nullToAbsent) {
return TrapPhotosCompanion(id: Value(id),cameraTrapId: Value(cameraTrapId),localFilePath: Value(localFilePath),dateTaken: Value(dateTaken),);
}
factory TrapPhoto.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return TrapPhoto(id: serializer.fromJson<int>(json['id']),cameraTrapId: serializer.fromJson<int>(json['cameraTrapId']),localFilePath: serializer.fromJson<String>(json['localFilePath']),dateTaken: serializer.fromJson<DateTime>(json['dateTaken']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<int>(id),'cameraTrapId': serializer.toJson<int>(cameraTrapId),'localFilePath': serializer.toJson<String>(localFilePath),'dateTaken': serializer.toJson<DateTime>(dateTaken),};}TrapPhoto copyWith({int? id,int? cameraTrapId,String? localFilePath,DateTime? dateTaken}) => TrapPhoto(id: id ?? this.id,cameraTrapId: cameraTrapId ?? this.cameraTrapId,localFilePath: localFilePath ?? this.localFilePath,dateTaken: dateTaken ?? this.dateTaken,);TrapPhoto copyWithCompanion(TrapPhotosCompanion data) {
return TrapPhoto(
id: data.id.present ? data.id.value : this.id,cameraTrapId: data.cameraTrapId.present ? data.cameraTrapId.value : this.cameraTrapId,localFilePath: data.localFilePath.present ? data.localFilePath.value : this.localFilePath,dateTaken: data.dateTaken.present ? data.dateTaken.value : this.dateTaken,);
}
@override
String toString() {return (StringBuffer('TrapPhoto(')..write('id: $id, ')..write('cameraTrapId: $cameraTrapId, ')..write('localFilePath: $localFilePath, ')..write('dateTaken: $dateTaken')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, cameraTrapId, localFilePath, dateTaken);@override
bool operator ==(Object other) => identical(this, other) || (other is TrapPhoto && other.id == this.id && other.cameraTrapId == this.cameraTrapId && other.localFilePath == this.localFilePath && other.dateTaken == this.dateTaken);
}class TrapPhotosCompanion extends UpdateCompanion<TrapPhoto> {
final Value<int> id;
final Value<int> cameraTrapId;
final Value<String> localFilePath;
final Value<DateTime> dateTaken;
const TrapPhotosCompanion({this.id = const Value.absent(),this.cameraTrapId = const Value.absent(),this.localFilePath = const Value.absent(),this.dateTaken = const Value.absent(),});
TrapPhotosCompanion.insert({this.id = const Value.absent(),required int cameraTrapId,required String localFilePath,required DateTime dateTaken,}): cameraTrapId = Value(cameraTrapId), localFilePath = Value(localFilePath), dateTaken = Value(dateTaken);
static Insertable<TrapPhoto> custom({Expression<int>? id, 
Expression<int>? cameraTrapId, 
Expression<String>? localFilePath, 
Expression<DateTime>? dateTaken, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (cameraTrapId != null)'camera_trap_id': cameraTrapId,if (localFilePath != null)'local_file_path': localFilePath,if (dateTaken != null)'date_taken': dateTaken,});
}TrapPhotosCompanion copyWith({Value<int>? id, Value<int>? cameraTrapId, Value<String>? localFilePath, Value<DateTime>? dateTaken}) {
return TrapPhotosCompanion(id: id ?? this.id,cameraTrapId: cameraTrapId ?? this.cameraTrapId,localFilePath: localFilePath ?? this.localFilePath,dateTaken: dateTaken ?? this.dateTaken,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<int>(id.value);}
if (cameraTrapId.present) {
map['camera_trap_id'] = Variable<int>(cameraTrapId.value);}
if (localFilePath.present) {
map['local_file_path'] = Variable<String>(localFilePath.value);}
if (dateTaken.present) {
map['date_taken'] = Variable<DateTime>(dateTaken.value);}
return map; 
}
@override
String toString() {return (StringBuffer('TrapPhotosCompanion(')..write('id: $id, ')..write('cameraTrapId: $cameraTrapId, ')..write('localFilePath: $localFilePath, ')..write('dateTaken: $dateTaken')..write(')')).toString();}
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $ProjectFoldersTable projectFolders = $ProjectFoldersTable(this);
late final $CameraTrapsTable cameraTraps = $CameraTrapsTable(this);
late final $TrapPhotosTable trapPhotos = $TrapPhotosTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [projectFolders, cameraTraps, trapPhotos];
@override
StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([WritePropagation(on: TableUpdateQuery.onTableName('project_folders' , limitUpdateKind: UpdateKind.delete), result: [TableUpdate('camera_traps', kind: UpdateKind.delete), ],), WritePropagation(on: TableUpdateQuery.onTableName('camera_traps' , limitUpdateKind: UpdateKind.delete), result: [TableUpdate('trap_photos', kind: UpdateKind.delete), ],), ],);
}
typedef $$ProjectFoldersTableCreateCompanionBuilder = ProjectFoldersCompanion Function({Value<int> id,required String uuid,required String name,required DateTime dateCreated,});
typedef $$ProjectFoldersTableUpdateCompanionBuilder = ProjectFoldersCompanion Function({Value<int> id,Value<String> uuid,Value<String> name,Value<DateTime> dateCreated,});
      final class $$ProjectFoldersTableReferences extends BaseReferences<
        _$AppDatabase,
        $ProjectFoldersTable,
        ProjectFolder> {
        $$ProjectFoldersTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                  
                  static MultiTypedResultKey<
          $CameraTrapsTable,
          List<CameraTrap>
        > _cameraTrapsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.cameraTraps, 
          aliasName: $_aliasNameGenerator(
            db.projectFolders.id,
            db.cameraTraps.projectId)
        );

          $$CameraTrapsTableProcessedTableManager get cameraTrapsRefs {
        final manager = $$CameraTrapsTableTableManager(
            $_db, $_db.cameraTraps
            ).filter(
              (f) => f.projectId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_cameraTrapsRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$ProjectFoldersTableFilterComposer extends Composer<
        _$AppDatabase,
        $ProjectFoldersTable> {
        $$ProjectFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated,
      builder: (column) => 
      ColumnFilters(column));
      
        Expression<bool> cameraTrapsRefs(
          Expression<bool> Function( $$CameraTrapsTableFilterComposer f) f
        ) {
                final $$CameraTrapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cameraTraps,
      getReferencedColumn: (t) => t.projectId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$CameraTrapsTableFilterComposer(
              $db: $db,
              $table: $db.cameraTraps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$ProjectFoldersTableOrderingComposer extends Composer<
        _$AppDatabase,
        $ProjectFoldersTable> {
        $$ProjectFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$ProjectFoldersTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $ProjectFoldersTable> {
        $$ProjectFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get name => $composableBuilder(
      column: $table.name,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated,
      builder: (column) => column);
      
        Expression<T> cameraTrapsRefs<T extends Object>(
          Expression<T> Function( $$CameraTrapsTableAnnotationComposer a) f
        ) {
                final $$CameraTrapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cameraTraps,
      getReferencedColumn: (t) => t.projectId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$CameraTrapsTableAnnotationComposer(
              $db: $db,
              $table: $db.cameraTraps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$ProjectFoldersTableTableManager extends RootTableManager    <_$AppDatabase,
    $ProjectFoldersTable,
    ProjectFolder,
    $$ProjectFoldersTableFilterComposer,
    $$ProjectFoldersTableOrderingComposer,
    $$ProjectFoldersTableAnnotationComposer,
    $$ProjectFoldersTableCreateCompanionBuilder,
    $$ProjectFoldersTableUpdateCompanionBuilder,
    (ProjectFolder,$$ProjectFoldersTableReferences),
    ProjectFolder,
    PrefetchHooks Function({bool cameraTrapsRefs})
    > {
    $$ProjectFoldersTableTableManager(_$AppDatabase db, $ProjectFoldersTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$ProjectFoldersTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$ProjectFoldersTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$ProjectFoldersTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<String> name = const Value.absent(),Value<DateTime> dateCreated = const Value.absent(),})=> ProjectFoldersCompanion(id: id,uuid: uuid,name: name,dateCreated: dateCreated,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required String name,required DateTime dateCreated,})=> ProjectFoldersCompanion.insert(id: id,uuid: uuid,name: name,dateCreated: dateCreated,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$ProjectFoldersTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({cameraTrapsRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (cameraTrapsRefs) db.cameraTraps
            ],
            addJoins: null,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (cameraTrapsRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$ProjectFoldersTableReferences._cameraTrapsRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$ProjectFoldersTableReferences(db, table, p0).cameraTrapsRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.projectId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$ProjectFoldersTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $ProjectFoldersTable,
    ProjectFolder,
    $$ProjectFoldersTableFilterComposer,
    $$ProjectFoldersTableOrderingComposer,
    $$ProjectFoldersTableAnnotationComposer,
    $$ProjectFoldersTableCreateCompanionBuilder,
    $$ProjectFoldersTableUpdateCompanionBuilder,
    (ProjectFolder,$$ProjectFoldersTableReferences),
    ProjectFolder,
    PrefetchHooks Function({bool cameraTrapsRefs})
    >;typedef $$CameraTrapsTableCreateCompanionBuilder = CameraTrapsCompanion Function({Value<int> id,required String uuid,required int projectId,required String trapName,required double latitude,required double longitude,required double gpsAccuracy,required String deployedBy,required String compassDirection,required DateTime dateTimeDeployed,required String envConditions,});
typedef $$CameraTrapsTableUpdateCompanionBuilder = CameraTrapsCompanion Function({Value<int> id,Value<String> uuid,Value<int> projectId,Value<String> trapName,Value<double> latitude,Value<double> longitude,Value<double> gpsAccuracy,Value<String> deployedBy,Value<String> compassDirection,Value<DateTime> dateTimeDeployed,Value<String> envConditions,});
      final class $$CameraTrapsTableReferences extends BaseReferences<
        _$AppDatabase,
        $CameraTrapsTable,
        CameraTrap> {
        $$CameraTrapsTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $ProjectFoldersTable _projectIdTable(_$AppDatabase db) => 
            db.projectFolders.createAlias($_aliasNameGenerator(
            db.cameraTraps.projectId,
            db.projectFolders.id));
          

        $$ProjectFoldersTableProcessedTableManager? get projectId {
          if ($_item.projectId == null) return null;
          final manager = $$ProjectFoldersTableTableManager($_db, $_db.projectFolders).filter((f) => f.id($_item.projectId!));
          final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }

          
                  static MultiTypedResultKey<
          $TrapPhotosTable,
          List<TrapPhoto>
        > _trapPhotosRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(
          db.trapPhotos, 
          aliasName: $_aliasNameGenerator(
            db.cameraTraps.id,
            db.trapPhotos.cameraTrapId)
        );

          $$TrapPhotosTableProcessedTableManager get trapPhotosRefs {
        final manager = $$TrapPhotosTableTableManager(
            $_db, $_db.trapPhotos
            ).filter(
              (f) => f.cameraTrapId.id(
              $_item.id
            )
          );

          final cache = $_typedResult.readTableOrNull(_trapPhotosRefsTable($_db));
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));


        }
        

      }class $$CameraTrapsTableFilterComposer extends Composer<
        _$AppDatabase,
        $CameraTrapsTable> {
        $$CameraTrapsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get trapName => $composableBuilder(
      column: $table.trapName,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get deployedBy => $composableBuilder(
      column: $table.deployedBy,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get compassDirection => $composableBuilder(
      column: $table.compassDirection,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get dateTimeDeployed => $composableBuilder(
      column: $table.dateTimeDeployed,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get envConditions => $composableBuilder(
      column: $table.envConditions,
      builder: (column) => 
      ColumnFilters(column));
      
        $$ProjectFoldersTableFilterComposer get projectId {
                final $$ProjectFoldersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projectFolders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$ProjectFoldersTableFilterComposer(
              $db: $db,
              $table: $db.projectFolders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        Expression<bool> trapPhotosRefs(
          Expression<bool> Function( $$TrapPhotosTableFilterComposer f) f
        ) {
                final $$TrapPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trapPhotos,
      getReferencedColumn: (t) => t.cameraTrapId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$TrapPhotosTableFilterComposer(
              $db: $db,
              $table: $db.trapPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$CameraTrapsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $CameraTrapsTable> {
        $$CameraTrapsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get trapName => $composableBuilder(
      column: $table.trapName,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get deployedBy => $composableBuilder(
      column: $table.deployedBy,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get compassDirection => $composableBuilder(
      column: $table.compassDirection,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get dateTimeDeployed => $composableBuilder(
      column: $table.dateTimeDeployed,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get envConditions => $composableBuilder(
      column: $table.envConditions,
      builder: (column) => 
      ColumnOrderings(column));
      
        $$ProjectFoldersTableOrderingComposer get projectId {
                final $$ProjectFoldersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projectFolders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$ProjectFoldersTableOrderingComposer(
              $db: $db,
              $table: $db.projectFolders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$CameraTrapsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $CameraTrapsTable> {
        $$CameraTrapsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get uuid => $composableBuilder(
      column: $table.uuid,
      builder: (column) => column);
      
GeneratedColumn<String> get trapName => $composableBuilder(
      column: $table.trapName,
      builder: (column) => column);
      
GeneratedColumn<double> get latitude => $composableBuilder(
      column: $table.latitude,
      builder: (column) => column);
      
GeneratedColumn<double> get longitude => $composableBuilder(
      column: $table.longitude,
      builder: (column) => column);
      
GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
      column: $table.gpsAccuracy,
      builder: (column) => column);
      
GeneratedColumn<String> get deployedBy => $composableBuilder(
      column: $table.deployedBy,
      builder: (column) => column);
      
GeneratedColumn<String> get compassDirection => $composableBuilder(
      column: $table.compassDirection,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get dateTimeDeployed => $composableBuilder(
      column: $table.dateTimeDeployed,
      builder: (column) => column);
      
GeneratedColumn<String> get envConditions => $composableBuilder(
      column: $table.envConditions,
      builder: (column) => column);
      
        $$ProjectFoldersTableAnnotationComposer get projectId {
                final $$ProjectFoldersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projectFolders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$ProjectFoldersTableAnnotationComposer(
              $db: $db,
              $table: $db.projectFolders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        Expression<T> trapPhotosRefs<T extends Object>(
          Expression<T> Function( $$TrapPhotosTableAnnotationComposer a) f
        ) {
                final $$TrapPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trapPhotos,
      getReferencedColumn: (t) => t.cameraTrapId,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$TrapPhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.trapPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return f(composer);
        }

        }
      class $$CameraTrapsTableTableManager extends RootTableManager    <_$AppDatabase,
    $CameraTrapsTable,
    CameraTrap,
    $$CameraTrapsTableFilterComposer,
    $$CameraTrapsTableOrderingComposer,
    $$CameraTrapsTableAnnotationComposer,
    $$CameraTrapsTableCreateCompanionBuilder,
    $$CameraTrapsTableUpdateCompanionBuilder,
    (CameraTrap,$$CameraTrapsTableReferences),
    CameraTrap,
    PrefetchHooks Function({bool projectId,bool trapPhotosRefs})
    > {
    $$CameraTrapsTableTableManager(_$AppDatabase db, $CameraTrapsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$CameraTrapsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$CameraTrapsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$CameraTrapsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<String> uuid = const Value.absent(),Value<int> projectId = const Value.absent(),Value<String> trapName = const Value.absent(),Value<double> latitude = const Value.absent(),Value<double> longitude = const Value.absent(),Value<double> gpsAccuracy = const Value.absent(),Value<String> deployedBy = const Value.absent(),Value<String> compassDirection = const Value.absent(),Value<DateTime> dateTimeDeployed = const Value.absent(),Value<String> envConditions = const Value.absent(),})=> CameraTrapsCompanion(id: id,uuid: uuid,projectId: projectId,trapName: trapName,latitude: latitude,longitude: longitude,gpsAccuracy: gpsAccuracy,deployedBy: deployedBy,compassDirection: compassDirection,dateTimeDeployed: dateTimeDeployed,envConditions: envConditions,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required String uuid,required int projectId,required String trapName,required double latitude,required double longitude,required double gpsAccuracy,required String deployedBy,required String compassDirection,required DateTime dateTimeDeployed,required String envConditions,})=> CameraTrapsCompanion.insert(id: id,uuid: uuid,projectId: projectId,trapName: trapName,latitude: latitude,longitude: longitude,gpsAccuracy: gpsAccuracy,deployedBy: deployedBy,compassDirection: compassDirection,dateTimeDeployed: dateTimeDeployed,envConditions: envConditions,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$CameraTrapsTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({projectId = false,trapPhotosRefs = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             if (trapPhotosRefs) db.trapPhotos
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (projectId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable:
                        $$CameraTrapsTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$CameraTrapsTableReferences._projectIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
                      if (trapPhotosRefs) await $_getPrefetchedData(
                  currentTable: table,
                  referencedTable:
                      $$CameraTrapsTableReferences._trapPhotosRefsTable(db),
                  managerFromTypedResult: (p0) =>
                      $$CameraTrapsTableReferences(db, table, p0).trapPhotosRefs,
                  referencedItemsForCurrentItem: (item, referencedItems) =>
                      referencedItems.where((e) => e.cameraTrapId == item.id),
                  typedResults: items)
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$CameraTrapsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $CameraTrapsTable,
    CameraTrap,
    $$CameraTrapsTableFilterComposer,
    $$CameraTrapsTableOrderingComposer,
    $$CameraTrapsTableAnnotationComposer,
    $$CameraTrapsTableCreateCompanionBuilder,
    $$CameraTrapsTableUpdateCompanionBuilder,
    (CameraTrap,$$CameraTrapsTableReferences),
    CameraTrap,
    PrefetchHooks Function({bool projectId,bool trapPhotosRefs})
    >;typedef $$TrapPhotosTableCreateCompanionBuilder = TrapPhotosCompanion Function({Value<int> id,required int cameraTrapId,required String localFilePath,required DateTime dateTaken,});
typedef $$TrapPhotosTableUpdateCompanionBuilder = TrapPhotosCompanion Function({Value<int> id,Value<int> cameraTrapId,Value<String> localFilePath,Value<DateTime> dateTaken,});
      final class $$TrapPhotosTableReferences extends BaseReferences<
        _$AppDatabase,
        $TrapPhotosTable,
        TrapPhoto> {
        $$TrapPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);
        
                          static $CameraTrapsTable _cameraTrapIdTable(_$AppDatabase db) => 
            db.cameraTraps.createAlias($_aliasNameGenerator(
            db.trapPhotos.cameraTrapId,
            db.cameraTraps.id));
          

        $$CameraTrapsTableProcessedTableManager? get cameraTrapId {
          if ($_item.cameraTrapId == null) return null;
          final manager = $$CameraTrapsTableTableManager($_db, $_db.cameraTraps).filter((f) => f.id($_item.cameraTrapId!));
          final item = $_typedResult.readTableOrNull(_cameraTrapIdTable($_db));
          if (item == null) return manager;
          return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
        }


      }class $$TrapPhotosTableFilterComposer extends Composer<
        _$AppDatabase,
        $TrapPhotosTable> {
        $$TrapPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get dateTaken => $composableBuilder(
      column: $table.dateTaken,
      builder: (column) => 
      ColumnFilters(column));
      
        $$CameraTrapsTableFilterComposer get cameraTrapId {
                final $$CameraTrapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cameraTrapId,
      referencedTable: $db.cameraTraps,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$CameraTrapsTableFilterComposer(
              $db: $db,
              $table: $db.cameraTraps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$TrapPhotosTableOrderingComposer extends Composer<
        _$AppDatabase,
        $TrapPhotosTable> {
        $$TrapPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get dateTaken => $composableBuilder(
      column: $table.dateTaken,
      builder: (column) => 
      ColumnOrderings(column));
      
        $$CameraTrapsTableOrderingComposer get cameraTrapId {
                final $$CameraTrapsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cameraTrapId,
      referencedTable: $db.cameraTraps,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$CameraTrapsTableOrderingComposer(
              $db: $db,
              $table: $db.cameraTraps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$TrapPhotosTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $TrapPhotosTable> {
        $$TrapPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<int> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get dateTaken => $composableBuilder(
      column: $table.dateTaken,
      builder: (column) => column);
      
        $$CameraTrapsTableAnnotationComposer get cameraTrapId {
                final $$CameraTrapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cameraTrapId,
      referencedTable: $db.cameraTraps,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder,{$addJoinBuilderToRootComposer,$removeJoinBuilderFromRootComposer }) => 
      $$CameraTrapsTableAnnotationComposer(
              $db: $db,
              $table: $db.cameraTraps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
        ));
          return composer;
        }
        }
      class $$TrapPhotosTableTableManager extends RootTableManager    <_$AppDatabase,
    $TrapPhotosTable,
    TrapPhoto,
    $$TrapPhotosTableFilterComposer,
    $$TrapPhotosTableOrderingComposer,
    $$TrapPhotosTableAnnotationComposer,
    $$TrapPhotosTableCreateCompanionBuilder,
    $$TrapPhotosTableUpdateCompanionBuilder,
    (TrapPhoto,$$TrapPhotosTableReferences),
    TrapPhoto,
    PrefetchHooks Function({bool cameraTrapId})
    > {
    $$TrapPhotosTableTableManager(_$AppDatabase db, $TrapPhotosTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$TrapPhotosTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$TrapPhotosTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$TrapPhotosTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<int> id = const Value.absent(),Value<int> cameraTrapId = const Value.absent(),Value<String> localFilePath = const Value.absent(),Value<DateTime> dateTaken = const Value.absent(),})=> TrapPhotosCompanion(id: id,cameraTrapId: cameraTrapId,localFilePath: localFilePath,dateTaken: dateTaken,),
        createCompanionCallback: ({Value<int> id = const Value.absent(),required int cameraTrapId,required String localFilePath,required DateTime dateTaken,})=> TrapPhotosCompanion.insert(id: id,cameraTrapId: cameraTrapId,localFilePath: localFilePath,dateTaken: dateTaken,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), $$TrapPhotosTableReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback:         ({cameraTrapId = false}){
          return PrefetchHooks(
            db: db,
            explicitlyWatchedTables: [
             
            ],
            addJoins: <T extends TableManagerState<dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic,dynamic>>(state) {

                                  if (cameraTrapId){
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cameraTrapId,
                    referencedTable:
                        $$TrapPhotosTableReferences._cameraTrapIdTable(db),
                    referencedColumn:
                        $$TrapPhotosTableReferences._cameraTrapIdTable(db).id,
                  ) as T;
               }

                return state;
              }
,
            getPrefetchedDataCallback: (items) async {
            return [
            
                ];
              },
          );
        }
,
        ));
        }
    typedef $$TrapPhotosTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $TrapPhotosTable,
    TrapPhoto,
    $$TrapPhotosTableFilterComposer,
    $$TrapPhotosTableOrderingComposer,
    $$TrapPhotosTableAnnotationComposer,
    $$TrapPhotosTableCreateCompanionBuilder,
    $$TrapPhotosTableUpdateCompanionBuilder,
    (TrapPhoto,$$TrapPhotosTableReferences),
    TrapPhoto,
    PrefetchHooks Function({bool cameraTrapId})
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$ProjectFoldersTableTableManager get projectFolders => $$ProjectFoldersTableTableManager(_db, _db.projectFolders);
$$CameraTrapsTableTableManager get cameraTraps => $$CameraTrapsTableTableManager(_db, _db.cameraTraps);
$$TrapPhotosTableTableManager get trapPhotos => $$TrapPhotosTableTableManager(_db, _db.trapPhotos);
}
