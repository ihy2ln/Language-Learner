// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LanguagesTable extends Languages
    with TableInfo<$LanguagesTable, LanguageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nativeNameMeta =
      const VerificationMeta('nativeName');
  @override
  late final GeneratedColumn<String> nativeName = GeneratedColumn<String>(
      'native_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Tier, String> tier =
      GeneratedColumn<String>('tier', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Tier>($LanguagesTable.$convertertier);
  static const VerificationMeta _hasCuratedContentMeta =
      const VerificationMeta('hasCuratedContent');
  @override
  late final GeneratedColumn<bool> hasCuratedContent = GeneratedColumn<bool>(
      'has_curated_content', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_curated_content" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasTtsMeta = const VerificationMeta('hasTts');
  @override
  late final GeneratedColumn<bool> hasTts = GeneratedColumn<bool>(
      'has_tts', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_tts" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasAsrMeta = const VerificationMeta('hasAsr');
  @override
  late final GeneratedColumn<bool> hasAsr = GeneratedColumn<bool>(
      'has_asr', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_asr" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasPronunciationScoringMeta =
      const VerificationMeta('hasPronunciationScoring');
  @override
  late final GeneratedColumn<bool> hasPronunciationScoring =
      GeneratedColumn<bool>('has_pronunciation_scoring', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("has_pronunciation_scoring" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _llmCorpusConstrainedMeta =
      const VerificationMeta('llmCorpusConstrained');
  @override
  late final GeneratedColumn<bool> llmCorpusConstrained = GeneratedColumn<bool>(
      'llm_corpus_constrained', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("llm_corpus_constrained" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<Script, String> script =
      GeneratedColumn<String>('script', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Script>($LanguagesTable.$converterscript);
  static const VerificationMeta _rtlMeta = const VerificationMeta('rtl');
  @override
  late final GeneratedColumn<bool> rtl = GeneratedColumn<bool>(
      'rtl', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("rtl" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _ttsVoiceHintMeta =
      const VerificationMeta('ttsVoiceHint');
  @override
  late final GeneratedColumn<String> ttsVoiceHint = GeneratedColumn<String>(
      'tts_voice_hint', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        code,
        name,
        nativeName,
        tier,
        hasCuratedContent,
        hasTts,
        hasAsr,
        hasPronunciationScoring,
        llmCorpusConstrained,
        script,
        rtl,
        ttsVoiceHint
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'languages';
  @override
  VerificationContext validateIntegrity(Insertable<LanguageRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('native_name')) {
      context.handle(
          _nativeNameMeta,
          nativeName.isAcceptableOrUnknown(
              data['native_name']!, _nativeNameMeta));
    } else if (isInserting) {
      context.missing(_nativeNameMeta);
    }
    if (data.containsKey('has_curated_content')) {
      context.handle(
          _hasCuratedContentMeta,
          hasCuratedContent.isAcceptableOrUnknown(
              data['has_curated_content']!, _hasCuratedContentMeta));
    }
    if (data.containsKey('has_tts')) {
      context.handle(_hasTtsMeta,
          hasTts.isAcceptableOrUnknown(data['has_tts']!, _hasTtsMeta));
    }
    if (data.containsKey('has_asr')) {
      context.handle(_hasAsrMeta,
          hasAsr.isAcceptableOrUnknown(data['has_asr']!, _hasAsrMeta));
    }
    if (data.containsKey('has_pronunciation_scoring')) {
      context.handle(
          _hasPronunciationScoringMeta,
          hasPronunciationScoring.isAcceptableOrUnknown(
              data['has_pronunciation_scoring']!,
              _hasPronunciationScoringMeta));
    }
    if (data.containsKey('llm_corpus_constrained')) {
      context.handle(
          _llmCorpusConstrainedMeta,
          llmCorpusConstrained.isAcceptableOrUnknown(
              data['llm_corpus_constrained']!, _llmCorpusConstrainedMeta));
    }
    if (data.containsKey('rtl')) {
      context.handle(
          _rtlMeta, rtl.isAcceptableOrUnknown(data['rtl']!, _rtlMeta));
    }
    if (data.containsKey('tts_voice_hint')) {
      context.handle(
          _ttsVoiceHintMeta,
          ttsVoiceHint.isAcceptableOrUnknown(
              data['tts_voice_hint']!, _ttsVoiceHintMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  LanguageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LanguageRow(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      nativeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}native_name'])!,
      tier: $LanguagesTable.$convertertier.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tier'])!),
      hasCuratedContent: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_curated_content'])!,
      hasTts: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_tts'])!,
      hasAsr: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_asr'])!,
      hasPronunciationScoring: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}has_pronunciation_scoring'])!,
      llmCorpusConstrained: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}llm_corpus_constrained'])!,
      script: $LanguagesTable.$converterscript.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}script'])!),
      rtl: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}rtl'])!,
      ttsVoiceHint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tts_voice_hint']),
    );
  }

  @override
  $LanguagesTable createAlias(String alias) {
    return $LanguagesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Tier, String, String> $convertertier =
      const EnumNameConverter<Tier>(Tier.values);
  static JsonTypeConverter2<Script, String, String> $converterscript =
      const EnumNameConverter<Script>(Script.values);
}

class LanguageRow extends DataClass implements Insertable<LanguageRow> {
  /// BCP-47, e.g. "es-419", "ja", "aig".
  final String code;
  final String name;
  final String nativeName;
  final Tier tier;
  final bool hasCuratedContent;
  final bool hasTts;
  final bool hasAsr;
  final bool hasPronunciationScoring;
  final bool llmCorpusConstrained;
  final Script script;
  final bool rtl;
  final String? ttsVoiceHint;
  const LanguageRow(
      {required this.code,
      required this.name,
      required this.nativeName,
      required this.tier,
      required this.hasCuratedContent,
      required this.hasTts,
      required this.hasAsr,
      required this.hasPronunciationScoring,
      required this.llmCorpusConstrained,
      required this.script,
      required this.rtl,
      this.ttsVoiceHint});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['native_name'] = Variable<String>(nativeName);
    {
      map['tier'] =
          Variable<String>($LanguagesTable.$convertertier.toSql(tier));
    }
    map['has_curated_content'] = Variable<bool>(hasCuratedContent);
    map['has_tts'] = Variable<bool>(hasTts);
    map['has_asr'] = Variable<bool>(hasAsr);
    map['has_pronunciation_scoring'] = Variable<bool>(hasPronunciationScoring);
    map['llm_corpus_constrained'] = Variable<bool>(llmCorpusConstrained);
    {
      map['script'] =
          Variable<String>($LanguagesTable.$converterscript.toSql(script));
    }
    map['rtl'] = Variable<bool>(rtl);
    if (!nullToAbsent || ttsVoiceHint != null) {
      map['tts_voice_hint'] = Variable<String>(ttsVoiceHint);
    }
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      code: Value(code),
      name: Value(name),
      nativeName: Value(nativeName),
      tier: Value(tier),
      hasCuratedContent: Value(hasCuratedContent),
      hasTts: Value(hasTts),
      hasAsr: Value(hasAsr),
      hasPronunciationScoring: Value(hasPronunciationScoring),
      llmCorpusConstrained: Value(llmCorpusConstrained),
      script: Value(script),
      rtl: Value(rtl),
      ttsVoiceHint: ttsVoiceHint == null && nullToAbsent
          ? const Value.absent()
          : Value(ttsVoiceHint),
    );
  }

  factory LanguageRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LanguageRow(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      nativeName: serializer.fromJson<String>(json['nativeName']),
      tier: $LanguagesTable.$convertertier
          .fromJson(serializer.fromJson<String>(json['tier'])),
      hasCuratedContent: serializer.fromJson<bool>(json['hasCuratedContent']),
      hasTts: serializer.fromJson<bool>(json['hasTts']),
      hasAsr: serializer.fromJson<bool>(json['hasAsr']),
      hasPronunciationScoring:
          serializer.fromJson<bool>(json['hasPronunciationScoring']),
      llmCorpusConstrained:
          serializer.fromJson<bool>(json['llmCorpusConstrained']),
      script: $LanguagesTable.$converterscript
          .fromJson(serializer.fromJson<String>(json['script'])),
      rtl: serializer.fromJson<bool>(json['rtl']),
      ttsVoiceHint: serializer.fromJson<String?>(json['ttsVoiceHint']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'nativeName': serializer.toJson<String>(nativeName),
      'tier': serializer
          .toJson<String>($LanguagesTable.$convertertier.toJson(tier)),
      'hasCuratedContent': serializer.toJson<bool>(hasCuratedContent),
      'hasTts': serializer.toJson<bool>(hasTts),
      'hasAsr': serializer.toJson<bool>(hasAsr),
      'hasPronunciationScoring':
          serializer.toJson<bool>(hasPronunciationScoring),
      'llmCorpusConstrained': serializer.toJson<bool>(llmCorpusConstrained),
      'script': serializer
          .toJson<String>($LanguagesTable.$converterscript.toJson(script)),
      'rtl': serializer.toJson<bool>(rtl),
      'ttsVoiceHint': serializer.toJson<String?>(ttsVoiceHint),
    };
  }

  LanguageRow copyWith(
          {String? code,
          String? name,
          String? nativeName,
          Tier? tier,
          bool? hasCuratedContent,
          bool? hasTts,
          bool? hasAsr,
          bool? hasPronunciationScoring,
          bool? llmCorpusConstrained,
          Script? script,
          bool? rtl,
          Value<String?> ttsVoiceHint = const Value.absent()}) =>
      LanguageRow(
        code: code ?? this.code,
        name: name ?? this.name,
        nativeName: nativeName ?? this.nativeName,
        tier: tier ?? this.tier,
        hasCuratedContent: hasCuratedContent ?? this.hasCuratedContent,
        hasTts: hasTts ?? this.hasTts,
        hasAsr: hasAsr ?? this.hasAsr,
        hasPronunciationScoring:
            hasPronunciationScoring ?? this.hasPronunciationScoring,
        llmCorpusConstrained: llmCorpusConstrained ?? this.llmCorpusConstrained,
        script: script ?? this.script,
        rtl: rtl ?? this.rtl,
        ttsVoiceHint:
            ttsVoiceHint.present ? ttsVoiceHint.value : this.ttsVoiceHint,
      );
  LanguageRow copyWithCompanion(LanguagesCompanion data) {
    return LanguageRow(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      nativeName:
          data.nativeName.present ? data.nativeName.value : this.nativeName,
      tier: data.tier.present ? data.tier.value : this.tier,
      hasCuratedContent: data.hasCuratedContent.present
          ? data.hasCuratedContent.value
          : this.hasCuratedContent,
      hasTts: data.hasTts.present ? data.hasTts.value : this.hasTts,
      hasAsr: data.hasAsr.present ? data.hasAsr.value : this.hasAsr,
      hasPronunciationScoring: data.hasPronunciationScoring.present
          ? data.hasPronunciationScoring.value
          : this.hasPronunciationScoring,
      llmCorpusConstrained: data.llmCorpusConstrained.present
          ? data.llmCorpusConstrained.value
          : this.llmCorpusConstrained,
      script: data.script.present ? data.script.value : this.script,
      rtl: data.rtl.present ? data.rtl.value : this.rtl,
      ttsVoiceHint: data.ttsVoiceHint.present
          ? data.ttsVoiceHint.value
          : this.ttsVoiceHint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LanguageRow(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('nativeName: $nativeName, ')
          ..write('tier: $tier, ')
          ..write('hasCuratedContent: $hasCuratedContent, ')
          ..write('hasTts: $hasTts, ')
          ..write('hasAsr: $hasAsr, ')
          ..write('hasPronunciationScoring: $hasPronunciationScoring, ')
          ..write('llmCorpusConstrained: $llmCorpusConstrained, ')
          ..write('script: $script, ')
          ..write('rtl: $rtl, ')
          ..write('ttsVoiceHint: $ttsVoiceHint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      code,
      name,
      nativeName,
      tier,
      hasCuratedContent,
      hasTts,
      hasAsr,
      hasPronunciationScoring,
      llmCorpusConstrained,
      script,
      rtl,
      ttsVoiceHint);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LanguageRow &&
          other.code == this.code &&
          other.name == this.name &&
          other.nativeName == this.nativeName &&
          other.tier == this.tier &&
          other.hasCuratedContent == this.hasCuratedContent &&
          other.hasTts == this.hasTts &&
          other.hasAsr == this.hasAsr &&
          other.hasPronunciationScoring == this.hasPronunciationScoring &&
          other.llmCorpusConstrained == this.llmCorpusConstrained &&
          other.script == this.script &&
          other.rtl == this.rtl &&
          other.ttsVoiceHint == this.ttsVoiceHint);
}

class LanguagesCompanion extends UpdateCompanion<LanguageRow> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> nativeName;
  final Value<Tier> tier;
  final Value<bool> hasCuratedContent;
  final Value<bool> hasTts;
  final Value<bool> hasAsr;
  final Value<bool> hasPronunciationScoring;
  final Value<bool> llmCorpusConstrained;
  final Value<Script> script;
  final Value<bool> rtl;
  final Value<String?> ttsVoiceHint;
  final Value<int> rowid;
  const LanguagesCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.nativeName = const Value.absent(),
    this.tier = const Value.absent(),
    this.hasCuratedContent = const Value.absent(),
    this.hasTts = const Value.absent(),
    this.hasAsr = const Value.absent(),
    this.hasPronunciationScoring = const Value.absent(),
    this.llmCorpusConstrained = const Value.absent(),
    this.script = const Value.absent(),
    this.rtl = const Value.absent(),
    this.ttsVoiceHint = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LanguagesCompanion.insert({
    required String code,
    required String name,
    required String nativeName,
    required Tier tier,
    this.hasCuratedContent = const Value.absent(),
    this.hasTts = const Value.absent(),
    this.hasAsr = const Value.absent(),
    this.hasPronunciationScoring = const Value.absent(),
    this.llmCorpusConstrained = const Value.absent(),
    required Script script,
    this.rtl = const Value.absent(),
    this.ttsVoiceHint = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name),
        nativeName = Value(nativeName),
        tier = Value(tier),
        script = Value(script);
  static Insertable<LanguageRow> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? nativeName,
    Expression<String>? tier,
    Expression<bool>? hasCuratedContent,
    Expression<bool>? hasTts,
    Expression<bool>? hasAsr,
    Expression<bool>? hasPronunciationScoring,
    Expression<bool>? llmCorpusConstrained,
    Expression<String>? script,
    Expression<bool>? rtl,
    Expression<String>? ttsVoiceHint,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (nativeName != null) 'native_name': nativeName,
      if (tier != null) 'tier': tier,
      if (hasCuratedContent != null) 'has_curated_content': hasCuratedContent,
      if (hasTts != null) 'has_tts': hasTts,
      if (hasAsr != null) 'has_asr': hasAsr,
      if (hasPronunciationScoring != null)
        'has_pronunciation_scoring': hasPronunciationScoring,
      if (llmCorpusConstrained != null)
        'llm_corpus_constrained': llmCorpusConstrained,
      if (script != null) 'script': script,
      if (rtl != null) 'rtl': rtl,
      if (ttsVoiceHint != null) 'tts_voice_hint': ttsVoiceHint,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LanguagesCompanion copyWith(
      {Value<String>? code,
      Value<String>? name,
      Value<String>? nativeName,
      Value<Tier>? tier,
      Value<bool>? hasCuratedContent,
      Value<bool>? hasTts,
      Value<bool>? hasAsr,
      Value<bool>? hasPronunciationScoring,
      Value<bool>? llmCorpusConstrained,
      Value<Script>? script,
      Value<bool>? rtl,
      Value<String?>? ttsVoiceHint,
      Value<int>? rowid}) {
    return LanguagesCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      tier: tier ?? this.tier,
      hasCuratedContent: hasCuratedContent ?? this.hasCuratedContent,
      hasTts: hasTts ?? this.hasTts,
      hasAsr: hasAsr ?? this.hasAsr,
      hasPronunciationScoring:
          hasPronunciationScoring ?? this.hasPronunciationScoring,
      llmCorpusConstrained: llmCorpusConstrained ?? this.llmCorpusConstrained,
      script: script ?? this.script,
      rtl: rtl ?? this.rtl,
      ttsVoiceHint: ttsVoiceHint ?? this.ttsVoiceHint,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nativeName.present) {
      map['native_name'] = Variable<String>(nativeName.value);
    }
    if (tier.present) {
      map['tier'] =
          Variable<String>($LanguagesTable.$convertertier.toSql(tier.value));
    }
    if (hasCuratedContent.present) {
      map['has_curated_content'] = Variable<bool>(hasCuratedContent.value);
    }
    if (hasTts.present) {
      map['has_tts'] = Variable<bool>(hasTts.value);
    }
    if (hasAsr.present) {
      map['has_asr'] = Variable<bool>(hasAsr.value);
    }
    if (hasPronunciationScoring.present) {
      map['has_pronunciation_scoring'] =
          Variable<bool>(hasPronunciationScoring.value);
    }
    if (llmCorpusConstrained.present) {
      map['llm_corpus_constrained'] =
          Variable<bool>(llmCorpusConstrained.value);
    }
    if (script.present) {
      map['script'] = Variable<String>(
          $LanguagesTable.$converterscript.toSql(script.value));
    }
    if (rtl.present) {
      map['rtl'] = Variable<bool>(rtl.value);
    }
    if (ttsVoiceHint.present) {
      map['tts_voice_hint'] = Variable<String>(ttsVoiceHint.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('nativeName: $nativeName, ')
          ..write('tier: $tier, ')
          ..write('hasCuratedContent: $hasCuratedContent, ')
          ..write('hasTts: $hasTts, ')
          ..write('hasAsr: $hasAsr, ')
          ..write('hasPronunciationScoring: $hasPronunciationScoring, ')
          ..write('llmCorpusConstrained: $llmCorpusConstrained, ')
          ..write('script: $script, ')
          ..write('rtl: $rtl, ')
          ..write('ttsVoiceHint: $ttsVoiceHint, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentBundlesTable extends ContentBundles
    with TableInfo<$ContentBundlesTable, ContentBundleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentBundlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentVersionMeta =
      const VerificationMeta('contentVersion');
  @override
  late final GeneratedColumn<String> contentVersion = GeneratedColumn<String>(
      'content_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _checksumMeta =
      const VerificationMeta('checksum');
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
      'checksum', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [languageCode, schemaVersion, contentVersion, checksum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_bundles';
  @override
  VerificationContext validateIntegrity(Insertable<ContentBundleRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
          _contentVersionMeta,
          contentVersion.isAcceptableOrUnknown(
              data['content_version']!, _contentVersionMeta));
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('checksum')) {
      context.handle(_checksumMeta,
          checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta));
    } else if (isInserting) {
      context.missing(_checksumMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {languageCode};
  @override
  ContentBundleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentBundleRow(
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schema_version'])!,
      contentVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}content_version'])!,
      checksum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checksum'])!,
    );
  }

  @override
  $ContentBundlesTable createAlias(String alias) {
    return $ContentBundlesTable(attachedDatabase, alias);
  }
}

class ContentBundleRow extends DataClass
    implements Insertable<ContentBundleRow> {
  final String languageCode;
  final int schemaVersion;
  final String contentVersion;
  final String checksum;
  const ContentBundleRow(
      {required this.languageCode,
      required this.schemaVersion,
      required this.contentVersion,
      required this.checksum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['language_code'] = Variable<String>(languageCode);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['content_version'] = Variable<String>(contentVersion);
    map['checksum'] = Variable<String>(checksum);
    return map;
  }

  ContentBundlesCompanion toCompanion(bool nullToAbsent) {
    return ContentBundlesCompanion(
      languageCode: Value(languageCode),
      schemaVersion: Value(schemaVersion),
      contentVersion: Value(contentVersion),
      checksum: Value(checksum),
    );
  }

  factory ContentBundleRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentBundleRow(
      languageCode: serializer.fromJson<String>(json['languageCode']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      contentVersion: serializer.fromJson<String>(json['contentVersion']),
      checksum: serializer.fromJson<String>(json['checksum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'languageCode': serializer.toJson<String>(languageCode),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'contentVersion': serializer.toJson<String>(contentVersion),
      'checksum': serializer.toJson<String>(checksum),
    };
  }

  ContentBundleRow copyWith(
          {String? languageCode,
          int? schemaVersion,
          String? contentVersion,
          String? checksum}) =>
      ContentBundleRow(
        languageCode: languageCode ?? this.languageCode,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        contentVersion: contentVersion ?? this.contentVersion,
        checksum: checksum ?? this.checksum,
      );
  ContentBundleRow copyWithCompanion(ContentBundlesCompanion data) {
    return ContentBundleRow(
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentBundleRow(')
          ..write('languageCode: $languageCode, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('checksum: $checksum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(languageCode, schemaVersion, contentVersion, checksum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentBundleRow &&
          other.languageCode == this.languageCode &&
          other.schemaVersion == this.schemaVersion &&
          other.contentVersion == this.contentVersion &&
          other.checksum == this.checksum);
}

class ContentBundlesCompanion extends UpdateCompanion<ContentBundleRow> {
  final Value<String> languageCode;
  final Value<int> schemaVersion;
  final Value<String> contentVersion;
  final Value<String> checksum;
  final Value<int> rowid;
  const ContentBundlesCompanion({
    this.languageCode = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.checksum = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentBundlesCompanion.insert({
    required String languageCode,
    required int schemaVersion,
    required String contentVersion,
    required String checksum,
    this.rowid = const Value.absent(),
  })  : languageCode = Value(languageCode),
        schemaVersion = Value(schemaVersion),
        contentVersion = Value(contentVersion),
        checksum = Value(checksum);
  static Insertable<ContentBundleRow> custom({
    Expression<String>? languageCode,
    Expression<int>? schemaVersion,
    Expression<String>? contentVersion,
    Expression<String>? checksum,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (languageCode != null) 'language_code': languageCode,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (contentVersion != null) 'content_version': contentVersion,
      if (checksum != null) 'checksum': checksum,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentBundlesCompanion copyWith(
      {Value<String>? languageCode,
      Value<int>? schemaVersion,
      Value<String>? contentVersion,
      Value<String>? checksum,
      Value<int>? rowid}) {
    return ContentBundlesCompanion(
      languageCode: languageCode ?? this.languageCode,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      contentVersion: contentVersion ?? this.contentVersion,
      checksum: checksum ?? this.checksum,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<String>(contentVersion.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentBundlesCompanion(')
          ..write('languageCode: $languageCode, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('checksum: $checksum, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, UnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES content_bundles (language_code)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Cefr?, String> level =
      GeneratedColumn<String>('level', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Cefr?>($UnitsTable.$converterlevel);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, languageCode, title, level, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(Insertable<UnitRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      level: $UnitsTable.$converterlevel.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }

  static TypeConverter<Cefr?, String?> $converterlevel = cefrConverter;
}

class UnitRow extends DataClass implements Insertable<UnitRow> {
  final String id;
  final String languageCode;
  final String title;

  /// `null` for Tier 0 content, which has no CEFR levels.
  final Cefr? level;

  /// Authored order within the bundle.
  final int position;
  const UnitRow(
      {required this.id,
      required this.languageCode,
      required this.title,
      this.level,
      required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['language_code'] = Variable<String>(languageCode);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<String>($UnitsTable.$converterlevel.toSql(level));
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: Value(id),
      languageCode: Value(languageCode),
      title: Value(title),
      level:
          level == null && nullToAbsent ? const Value.absent() : Value(level),
      position: Value(position),
    );
  }

  factory UnitRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitRow(
      id: serializer.fromJson<String>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      title: serializer.fromJson<String>(json['title']),
      level: serializer.fromJson<Cefr?>(json['level']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'title': serializer.toJson<String>(title),
      'level': serializer.toJson<Cefr?>(level),
      'position': serializer.toJson<int>(position),
    };
  }

  UnitRow copyWith(
          {String? id,
          String? languageCode,
          String? title,
          Value<Cefr?> level = const Value.absent(),
          int? position}) =>
      UnitRow(
        id: id ?? this.id,
        languageCode: languageCode ?? this.languageCode,
        title: title ?? this.title,
        level: level.present ? level.value : this.level,
        position: position ?? this.position,
      );
  UnitRow copyWithCompanion(UnitsCompanion data) {
    return UnitRow(
      id: data.id.present ? data.id.value : this.id,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      title: data.title.present ? data.title.value : this.title,
      level: data.level.present ? data.level.value : this.level,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitRow(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, languageCode, title, level, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitRow &&
          other.id == this.id &&
          other.languageCode == this.languageCode &&
          other.title == this.title &&
          other.level == this.level &&
          other.position == this.position);
}

class UnitsCompanion extends UpdateCompanion<UnitRow> {
  final Value<String> id;
  final Value<String> languageCode;
  final Value<String> title;
  final Value<Cefr?> level;
  final Value<int> position;
  final Value<int> rowid;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.title = const Value.absent(),
    this.level = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnitsCompanion.insert({
    required String id,
    required String languageCode,
    required String title,
    this.level = const Value.absent(),
    required int position,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        languageCode = Value(languageCode),
        title = Value(title),
        position = Value(position);
  static Insertable<UnitRow> custom({
    Expression<String>? id,
    Expression<String>? languageCode,
    Expression<String>? title,
    Expression<String>? level,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (title != null) 'title': title,
      if (level != null) 'level': level,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? languageCode,
      Value<String>? title,
      Value<Cefr?>? level,
      Value<int>? position,
      Value<int>? rowid}) {
    return UnitsCompanion(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      title: title ?? this.title,
      level: level ?? this.level,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (level.present) {
      map['level'] =
          Variable<String>($UnitsTable.$converterlevel.toSql(level.value));
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrammarNotesTable extends GrammarNotes
    with TableInfo<$GrammarNotesTable, GrammarNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrammarNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES units (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, unitId, title, body, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grammar_notes';
  @override
  VerificationContext validateIntegrity(Insertable<GrammarNoteRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrammarNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrammarNoteRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $GrammarNotesTable createAlias(String alias) {
    return $GrammarNotesTable(attachedDatabase, alias);
  }
}

class GrammarNoteRow extends DataClass implements Insertable<GrammarNoteRow> {
  final String id;
  final String unitId;
  final String title;
  final String body;
  final int position;
  const GrammarNoteRow(
      {required this.id,
      required this.unitId,
      required this.title,
      required this.body,
      required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unit_id'] = Variable<String>(unitId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['position'] = Variable<int>(position);
    return map;
  }

  GrammarNotesCompanion toCompanion(bool nullToAbsent) {
    return GrammarNotesCompanion(
      id: Value(id),
      unitId: Value(unitId),
      title: Value(title),
      body: Value(body),
      position: Value(position),
    );
  }

  factory GrammarNoteRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrammarNoteRow(
      id: serializer.fromJson<String>(json['id']),
      unitId: serializer.fromJson<String>(json['unitId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitId': serializer.toJson<String>(unitId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'position': serializer.toJson<int>(position),
    };
  }

  GrammarNoteRow copyWith(
          {String? id,
          String? unitId,
          String? title,
          String? body,
          int? position}) =>
      GrammarNoteRow(
        id: id ?? this.id,
        unitId: unitId ?? this.unitId,
        title: title ?? this.title,
        body: body ?? this.body,
        position: position ?? this.position,
      );
  GrammarNoteRow copyWithCompanion(GrammarNotesCompanion data) {
    return GrammarNoteRow(
      id: data.id.present ? data.id.value : this.id,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrammarNoteRow(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, unitId, title, body, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarNoteRow &&
          other.id == this.id &&
          other.unitId == this.unitId &&
          other.title == this.title &&
          other.body == this.body &&
          other.position == this.position);
}

class GrammarNotesCompanion extends UpdateCompanion<GrammarNoteRow> {
  final Value<String> id;
  final Value<String> unitId;
  final Value<String> title;
  final Value<String> body;
  final Value<int> position;
  final Value<int> rowid;
  const GrammarNotesCompanion({
    this.id = const Value.absent(),
    this.unitId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrammarNotesCompanion.insert({
    required String id,
    required String unitId,
    required String title,
    required String body,
    required int position,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        unitId = Value(unitId),
        title = Value(title),
        body = Value(body),
        position = Value(position);
  static Insertable<GrammarNoteRow> custom({
    Expression<String>? id,
    Expression<String>? unitId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitId != null) 'unit_id': unitId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrammarNotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? unitId,
      Value<String>? title,
      Value<String>? body,
      Value<int>? position,
      Value<int>? rowid}) {
    return GrammarNotesCompanion(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      title: title ?? this.title,
      body: body ?? this.body,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrammarNotesCompanion(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, ItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES units (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<ItemType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ItemType>($ItemsTable.$convertertype);
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
      'target', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nativeMeta = const VerificationMeta('native');
  @override
  late final GeneratedColumn<String> native = GeneratedColumn<String>(
      'native', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioRefMeta =
      const VerificationMeta('audioRef');
  @override
  late final GeneratedColumn<String> audioRef = GeneratedColumn<String>(
      'audio_ref', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _altSpellingMeta =
      const VerificationMeta('altSpelling');
  @override
  late final GeneratedColumn<String> altSpelling = GeneratedColumn<String>(
      'alt_spelling', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _furiganaMeta =
      const VerificationMeta('furigana');
  @override
  late final GeneratedColumn<String> furigana = GeneratedColumn<String>(
      'furigana', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pinyinMeta = const VerificationMeta('pinyin');
  @override
  late final GeneratedColumn<String> pinyin = GeneratedColumn<String>(
      'pinyin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pitchAccentMeta =
      const VerificationMeta('pitchAccent');
  @override
  late final GeneratedColumn<String> pitchAccent = GeneratedColumn<String>(
      'pitch_accent', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        unitId,
        type,
        target,
        native,
        audioRef,
        altSpelling,
        furigana,
        pinyin,
        pitchAccent,
        note,
        position
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<ItemRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('target')) {
      context.handle(_targetMeta,
          target.isAcceptableOrUnknown(data['target']!, _targetMeta));
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('native')) {
      context.handle(_nativeMeta,
          native.isAcceptableOrUnknown(data['native']!, _nativeMeta));
    } else if (isInserting) {
      context.missing(_nativeMeta);
    }
    if (data.containsKey('audio_ref')) {
      context.handle(_audioRefMeta,
          audioRef.isAcceptableOrUnknown(data['audio_ref']!, _audioRefMeta));
    }
    if (data.containsKey('alt_spelling')) {
      context.handle(
          _altSpellingMeta,
          altSpelling.isAcceptableOrUnknown(
              data['alt_spelling']!, _altSpellingMeta));
    }
    if (data.containsKey('furigana')) {
      context.handle(_furiganaMeta,
          furigana.isAcceptableOrUnknown(data['furigana']!, _furiganaMeta));
    }
    if (data.containsKey('pinyin')) {
      context.handle(_pinyinMeta,
          pinyin.isAcceptableOrUnknown(data['pinyin']!, _pinyinMeta));
    }
    if (data.containsKey('pitch_accent')) {
      context.handle(
          _pitchAccentMeta,
          pitchAccent.isAcceptableOrUnknown(
              data['pitch_accent']!, _pitchAccentMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id'])!,
      type: $ItemsTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      target: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target'])!,
      native: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}native'])!,
      audioRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_ref']),
      altSpelling: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alt_spelling']),
      furigana: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}furigana']),
      pinyin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pinyin']),
      pitchAccent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pitch_accent']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ItemType, String, String> $convertertype =
      const EnumNameConverter<ItemType>(ItemType.values);
}

class ItemRow extends DataClass implements Insertable<ItemRow> {
  final String id;
  final String unitId;
  final ItemType type;
  final String target;
  final String native;
  final String? audioRef;
  final String? altSpelling;
  final String? furigana;
  final String? pinyin;
  final String? pitchAccent;
  final String? note;

  /// Authored order within the unit; backs `Unit.itemIds`.
  final int position;
  const ItemRow(
      {required this.id,
      required this.unitId,
      required this.type,
      required this.target,
      required this.native,
      this.audioRef,
      this.altSpelling,
      this.furigana,
      this.pinyin,
      this.pitchAccent,
      this.note,
      required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unit_id'] = Variable<String>(unitId);
    {
      map['type'] = Variable<String>($ItemsTable.$convertertype.toSql(type));
    }
    map['target'] = Variable<String>(target);
    map['native'] = Variable<String>(native);
    if (!nullToAbsent || audioRef != null) {
      map['audio_ref'] = Variable<String>(audioRef);
    }
    if (!nullToAbsent || altSpelling != null) {
      map['alt_spelling'] = Variable<String>(altSpelling);
    }
    if (!nullToAbsent || furigana != null) {
      map['furigana'] = Variable<String>(furigana);
    }
    if (!nullToAbsent || pinyin != null) {
      map['pinyin'] = Variable<String>(pinyin);
    }
    if (!nullToAbsent || pitchAccent != null) {
      map['pitch_accent'] = Variable<String>(pitchAccent);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      unitId: Value(unitId),
      type: Value(type),
      target: Value(target),
      native: Value(native),
      audioRef: audioRef == null && nullToAbsent
          ? const Value.absent()
          : Value(audioRef),
      altSpelling: altSpelling == null && nullToAbsent
          ? const Value.absent()
          : Value(altSpelling),
      furigana: furigana == null && nullToAbsent
          ? const Value.absent()
          : Value(furigana),
      pinyin:
          pinyin == null && nullToAbsent ? const Value.absent() : Value(pinyin),
      pitchAccent: pitchAccent == null && nullToAbsent
          ? const Value.absent()
          : Value(pitchAccent),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      position: Value(position),
    );
  }

  factory ItemRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemRow(
      id: serializer.fromJson<String>(json['id']),
      unitId: serializer.fromJson<String>(json['unitId']),
      type: $ItemsTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      target: serializer.fromJson<String>(json['target']),
      native: serializer.fromJson<String>(json['native']),
      audioRef: serializer.fromJson<String?>(json['audioRef']),
      altSpelling: serializer.fromJson<String?>(json['altSpelling']),
      furigana: serializer.fromJson<String?>(json['furigana']),
      pinyin: serializer.fromJson<String?>(json['pinyin']),
      pitchAccent: serializer.fromJson<String?>(json['pitchAccent']),
      note: serializer.fromJson<String?>(json['note']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitId': serializer.toJson<String>(unitId),
      'type':
          serializer.toJson<String>($ItemsTable.$convertertype.toJson(type)),
      'target': serializer.toJson<String>(target),
      'native': serializer.toJson<String>(native),
      'audioRef': serializer.toJson<String?>(audioRef),
      'altSpelling': serializer.toJson<String?>(altSpelling),
      'furigana': serializer.toJson<String?>(furigana),
      'pinyin': serializer.toJson<String?>(pinyin),
      'pitchAccent': serializer.toJson<String?>(pitchAccent),
      'note': serializer.toJson<String?>(note),
      'position': serializer.toJson<int>(position),
    };
  }

  ItemRow copyWith(
          {String? id,
          String? unitId,
          ItemType? type,
          String? target,
          String? native,
          Value<String?> audioRef = const Value.absent(),
          Value<String?> altSpelling = const Value.absent(),
          Value<String?> furigana = const Value.absent(),
          Value<String?> pinyin = const Value.absent(),
          Value<String?> pitchAccent = const Value.absent(),
          Value<String?> note = const Value.absent(),
          int? position}) =>
      ItemRow(
        id: id ?? this.id,
        unitId: unitId ?? this.unitId,
        type: type ?? this.type,
        target: target ?? this.target,
        native: native ?? this.native,
        audioRef: audioRef.present ? audioRef.value : this.audioRef,
        altSpelling: altSpelling.present ? altSpelling.value : this.altSpelling,
        furigana: furigana.present ? furigana.value : this.furigana,
        pinyin: pinyin.present ? pinyin.value : this.pinyin,
        pitchAccent: pitchAccent.present ? pitchAccent.value : this.pitchAccent,
        note: note.present ? note.value : this.note,
        position: position ?? this.position,
      );
  ItemRow copyWithCompanion(ItemsCompanion data) {
    return ItemRow(
      id: data.id.present ? data.id.value : this.id,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      type: data.type.present ? data.type.value : this.type,
      target: data.target.present ? data.target.value : this.target,
      native: data.native.present ? data.native.value : this.native,
      audioRef: data.audioRef.present ? data.audioRef.value : this.audioRef,
      altSpelling:
          data.altSpelling.present ? data.altSpelling.value : this.altSpelling,
      furigana: data.furigana.present ? data.furigana.value : this.furigana,
      pinyin: data.pinyin.present ? data.pinyin.value : this.pinyin,
      pitchAccent:
          data.pitchAccent.present ? data.pitchAccent.value : this.pitchAccent,
      note: data.note.present ? data.note.value : this.note,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemRow(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('type: $type, ')
          ..write('target: $target, ')
          ..write('native: $native, ')
          ..write('audioRef: $audioRef, ')
          ..write('altSpelling: $altSpelling, ')
          ..write('furigana: $furigana, ')
          ..write('pinyin: $pinyin, ')
          ..write('pitchAccent: $pitchAccent, ')
          ..write('note: $note, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, unitId, type, target, native, audioRef,
      altSpelling, furigana, pinyin, pitchAccent, note, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemRow &&
          other.id == this.id &&
          other.unitId == this.unitId &&
          other.type == this.type &&
          other.target == this.target &&
          other.native == this.native &&
          other.audioRef == this.audioRef &&
          other.altSpelling == this.altSpelling &&
          other.furigana == this.furigana &&
          other.pinyin == this.pinyin &&
          other.pitchAccent == this.pitchAccent &&
          other.note == this.note &&
          other.position == this.position);
}

class ItemsCompanion extends UpdateCompanion<ItemRow> {
  final Value<String> id;
  final Value<String> unitId;
  final Value<ItemType> type;
  final Value<String> target;
  final Value<String> native;
  final Value<String?> audioRef;
  final Value<String?> altSpelling;
  final Value<String?> furigana;
  final Value<String?> pinyin;
  final Value<String?> pitchAccent;
  final Value<String?> note;
  final Value<int> position;
  final Value<int> rowid;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.unitId = const Value.absent(),
    this.type = const Value.absent(),
    this.target = const Value.absent(),
    this.native = const Value.absent(),
    this.audioRef = const Value.absent(),
    this.altSpelling = const Value.absent(),
    this.furigana = const Value.absent(),
    this.pinyin = const Value.absent(),
    this.pitchAccent = const Value.absent(),
    this.note = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    required String id,
    required String unitId,
    required ItemType type,
    required String target,
    required String native,
    this.audioRef = const Value.absent(),
    this.altSpelling = const Value.absent(),
    this.furigana = const Value.absent(),
    this.pinyin = const Value.absent(),
    this.pitchAccent = const Value.absent(),
    this.note = const Value.absent(),
    required int position,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        unitId = Value(unitId),
        type = Value(type),
        target = Value(target),
        native = Value(native),
        position = Value(position);
  static Insertable<ItemRow> custom({
    Expression<String>? id,
    Expression<String>? unitId,
    Expression<String>? type,
    Expression<String>? target,
    Expression<String>? native,
    Expression<String>? audioRef,
    Expression<String>? altSpelling,
    Expression<String>? furigana,
    Expression<String>? pinyin,
    Expression<String>? pitchAccent,
    Expression<String>? note,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitId != null) 'unit_id': unitId,
      if (type != null) 'type': type,
      if (target != null) 'target': target,
      if (native != null) 'native': native,
      if (audioRef != null) 'audio_ref': audioRef,
      if (altSpelling != null) 'alt_spelling': altSpelling,
      if (furigana != null) 'furigana': furigana,
      if (pinyin != null) 'pinyin': pinyin,
      if (pitchAccent != null) 'pitch_accent': pitchAccent,
      if (note != null) 'note': note,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? unitId,
      Value<ItemType>? type,
      Value<String>? target,
      Value<String>? native,
      Value<String?>? audioRef,
      Value<String?>? altSpelling,
      Value<String?>? furigana,
      Value<String?>? pinyin,
      Value<String?>? pitchAccent,
      Value<String?>? note,
      Value<int>? position,
      Value<int>? rowid}) {
    return ItemsCompanion(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      type: type ?? this.type,
      target: target ?? this.target,
      native: native ?? this.native,
      audioRef: audioRef ?? this.audioRef,
      altSpelling: altSpelling ?? this.altSpelling,
      furigana: furigana ?? this.furigana,
      pinyin: pinyin ?? this.pinyin,
      pitchAccent: pitchAccent ?? this.pitchAccent,
      note: note ?? this.note,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($ItemsTable.$convertertype.toSql(type.value));
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (native.present) {
      map['native'] = Variable<String>(native.value);
    }
    if (audioRef.present) {
      map['audio_ref'] = Variable<String>(audioRef.value);
    }
    if (altSpelling.present) {
      map['alt_spelling'] = Variable<String>(altSpelling.value);
    }
    if (furigana.present) {
      map['furigana'] = Variable<String>(furigana.value);
    }
    if (pinyin.present) {
      map['pinyin'] = Variable<String>(pinyin.value);
    }
    if (pitchAccent.present) {
      map['pitch_accent'] = Variable<String>(pitchAccent.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('type: $type, ')
          ..write('target: $target, ')
          ..write('native: $native, ')
          ..write('audioRef: $audioRef, ')
          ..write('altSpelling: $altSpelling, ')
          ..write('furigana: $furigana, ')
          ..write('pinyin: $pinyin, ')
          ..write('pitchAccent: $pitchAccent, ')
          ..write('note: $note, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrammarNoteExamplesTable extends GrammarNoteExamples
    with TableInfo<$GrammarNoteExamplesTable, GrammarNoteExampleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrammarNoteExamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES grammar_notes (id)'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [noteId, itemId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grammar_note_examples';
  @override
  VerificationContext validateIntegrity(
      Insertable<GrammarNoteExampleRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {noteId, itemId};
  @override
  GrammarNoteExampleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrammarNoteExampleRow(
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
    );
  }

  @override
  $GrammarNoteExamplesTable createAlias(String alias) {
    return $GrammarNoteExamplesTable(attachedDatabase, alias);
  }
}

class GrammarNoteExampleRow extends DataClass
    implements Insertable<GrammarNoteExampleRow> {
  final String noteId;
  final String itemId;
  final int position;
  const GrammarNoteExampleRow(
      {required this.noteId, required this.itemId, required this.position});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note_id'] = Variable<String>(noteId);
    map['item_id'] = Variable<String>(itemId);
    map['position'] = Variable<int>(position);
    return map;
  }

  GrammarNoteExamplesCompanion toCompanion(bool nullToAbsent) {
    return GrammarNoteExamplesCompanion(
      noteId: Value(noteId),
      itemId: Value(itemId),
      position: Value(position),
    );
  }

  factory GrammarNoteExampleRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrammarNoteExampleRow(
      noteId: serializer.fromJson<String>(json['noteId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'noteId': serializer.toJson<String>(noteId),
      'itemId': serializer.toJson<String>(itemId),
      'position': serializer.toJson<int>(position),
    };
  }

  GrammarNoteExampleRow copyWith(
          {String? noteId, String? itemId, int? position}) =>
      GrammarNoteExampleRow(
        noteId: noteId ?? this.noteId,
        itemId: itemId ?? this.itemId,
        position: position ?? this.position,
      );
  GrammarNoteExampleRow copyWithCompanion(GrammarNoteExamplesCompanion data) {
    return GrammarNoteExampleRow(
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrammarNoteExampleRow(')
          ..write('noteId: $noteId, ')
          ..write('itemId: $itemId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(noteId, itemId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrammarNoteExampleRow &&
          other.noteId == this.noteId &&
          other.itemId == this.itemId &&
          other.position == this.position);
}

class GrammarNoteExamplesCompanion
    extends UpdateCompanion<GrammarNoteExampleRow> {
  final Value<String> noteId;
  final Value<String> itemId;
  final Value<int> position;
  final Value<int> rowid;
  const GrammarNoteExamplesCompanion({
    this.noteId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrammarNoteExamplesCompanion.insert({
    required String noteId,
    required String itemId,
    required int position,
    this.rowid = const Value.absent(),
  })  : noteId = Value(noteId),
        itemId = Value(itemId),
        position = Value(position);
  static Insertable<GrammarNoteExampleRow> custom({
    Expression<String>? noteId,
    Expression<String>? itemId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (noteId != null) 'note_id': noteId,
      if (itemId != null) 'item_id': itemId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrammarNoteExamplesCompanion copyWith(
      {Value<String>? noteId,
      Value<String>? itemId,
      Value<int>? position,
      Value<int>? rowid}) {
    return GrammarNoteExamplesCompanion(
      noteId: noteId ?? this.noteId,
      itemId: itemId ?? this.itemId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrammarNoteExamplesCompanion(')
          ..write('noteId: $noteId, ')
          ..write('itemId: $itemId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemTagsTable extends ItemTags
    with TableInfo<$ItemTagsTable, ItemTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [itemId, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_tags';
  @override
  VerificationContext validateIntegrity(Insertable<ItemTagRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId, tag};
  @override
  ItemTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTagRow(
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $ItemTagsTable createAlias(String alias) {
    return $ItemTagsTable(attachedDatabase, alias);
  }
}

class ItemTagRow extends DataClass implements Insertable<ItemTagRow> {
  final String itemId;
  final String tag;
  const ItemTagRow({required this.itemId, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  ItemTagsCompanion toCompanion(bool nullToAbsent) {
    return ItemTagsCompanion(
      itemId: Value(itemId),
      tag: Value(tag),
    );
  }

  factory ItemTagRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTagRow(
      itemId: serializer.fromJson<String>(json['itemId']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'tag': serializer.toJson<String>(tag),
    };
  }

  ItemTagRow copyWith({String? itemId, String? tag}) => ItemTagRow(
        itemId: itemId ?? this.itemId,
        tag: tag ?? this.tag,
      );
  ItemTagRow copyWithCompanion(ItemTagsCompanion data) {
    return ItemTagRow(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemTagRow(')
          ..write('itemId: $itemId, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTagRow &&
          other.itemId == this.itemId &&
          other.tag == this.tag);
}

class ItemTagsCompanion extends UpdateCompanion<ItemTagRow> {
  final Value<String> itemId;
  final Value<String> tag;
  final Value<int> rowid;
  const ItemTagsCompanion({
    this.itemId = const Value.absent(),
    this.tag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemTagsCompanion.insert({
    required String itemId,
    required String tag,
    this.rowid = const Value.absent(),
  })  : itemId = Value(itemId),
        tag = Value(tag);
  static Insertable<ItemTagRow> custom({
    Expression<String>? itemId,
    Expression<String>? tag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (tag != null) 'tag': tag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemTagsCompanion copyWith(
      {Value<String>? itemId, Value<String>? tag, Value<int>? rowid}) {
    return ItemTagsCompanion(
      itemId: itemId ?? this.itemId,
      tag: tag ?? this.tag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTagsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('tag: $tag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProgressTableTable extends UserProgressTable
    with TableInfo<$UserProgressTableTable, UserProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES languages (code)'));
  static const VerificationMeta _stabilityMeta =
      const VerificationMeta('stability');
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
      'stability', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lastReviewMeta =
      const VerificationMeta('lastReview');
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
      'last_review', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
      'due_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
      'lapses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        itemId,
        languageCode,
        stability,
        difficulty,
        lastReview,
        dueAt,
        lapses,
        reps
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserProgressRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('stability')) {
      context.handle(_stabilityMeta,
          stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta));
    } else if (isInserting) {
      context.missing(_stabilityMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('last_review')) {
      context.handle(
          _lastReviewMeta,
          lastReview.isAcceptableOrUnknown(
              data['last_review']!, _lastReviewMeta));
    } else if (isInserting) {
      context.missing(_lastReviewMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
          _dueAtMeta, dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta));
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('lapses')) {
      context.handle(_lapsesMeta,
          lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  UserProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressRow(
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      stability: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stability'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty'])!,
      lastReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_review'])!,
      dueAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_at'])!,
      lapses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lapses'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
    );
  }

  @override
  $UserProgressTableTable createAlias(String alias) {
    return $UserProgressTableTable(attachedDatabase, alias);
  }
}

class UserProgressRow extends DataClass implements Insertable<UserProgressRow> {
  final String itemId;
  final String languageCode;
  final double stability;
  final double difficulty;
  final DateTime lastReview;
  final DateTime dueAt;
  final int lapses;
  final int reps;
  const UserProgressRow(
      {required this.itemId,
      required this.languageCode,
      required this.stability,
      required this.difficulty,
      required this.lastReview,
      required this.dueAt,
      required this.lapses,
      required this.reps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['language_code'] = Variable<String>(languageCode);
    map['stability'] = Variable<double>(stability);
    map['difficulty'] = Variable<double>(difficulty);
    map['last_review'] = Variable<DateTime>(lastReview);
    map['due_at'] = Variable<DateTime>(dueAt);
    map['lapses'] = Variable<int>(lapses);
    map['reps'] = Variable<int>(reps);
    return map;
  }

  UserProgressTableCompanion toCompanion(bool nullToAbsent) {
    return UserProgressTableCompanion(
      itemId: Value(itemId),
      languageCode: Value(languageCode),
      stability: Value(stability),
      difficulty: Value(difficulty),
      lastReview: Value(lastReview),
      dueAt: Value(dueAt),
      lapses: Value(lapses),
      reps: Value(reps),
    );
  }

  factory UserProgressRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressRow(
      itemId: serializer.fromJson<String>(json['itemId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      stability: serializer.fromJson<double>(json['stability']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      lastReview: serializer.fromJson<DateTime>(json['lastReview']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      lapses: serializer.fromJson<int>(json['lapses']),
      reps: serializer.fromJson<int>(json['reps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'languageCode': serializer.toJson<String>(languageCode),
      'stability': serializer.toJson<double>(stability),
      'difficulty': serializer.toJson<double>(difficulty),
      'lastReview': serializer.toJson<DateTime>(lastReview),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'lapses': serializer.toJson<int>(lapses),
      'reps': serializer.toJson<int>(reps),
    };
  }

  UserProgressRow copyWith(
          {String? itemId,
          String? languageCode,
          double? stability,
          double? difficulty,
          DateTime? lastReview,
          DateTime? dueAt,
          int? lapses,
          int? reps}) =>
      UserProgressRow(
        itemId: itemId ?? this.itemId,
        languageCode: languageCode ?? this.languageCode,
        stability: stability ?? this.stability,
        difficulty: difficulty ?? this.difficulty,
        lastReview: lastReview ?? this.lastReview,
        dueAt: dueAt ?? this.dueAt,
        lapses: lapses ?? this.lapses,
        reps: reps ?? this.reps,
      );
  UserProgressRow copyWithCompanion(UserProgressTableCompanion data) {
    return UserProgressRow(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      lastReview:
          data.lastReview.present ? data.lastReview.value : this.lastReview,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      reps: data.reps.present ? data.reps.value : this.reps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressRow(')
          ..write('itemId: $itemId, ')
          ..write('languageCode: $languageCode, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('lastReview: $lastReview, ')
          ..write('dueAt: $dueAt, ')
          ..write('lapses: $lapses, ')
          ..write('reps: $reps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, languageCode, stability, difficulty,
      lastReview, dueAt, lapses, reps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressRow &&
          other.itemId == this.itemId &&
          other.languageCode == this.languageCode &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.lastReview == this.lastReview &&
          other.dueAt == this.dueAt &&
          other.lapses == this.lapses &&
          other.reps == this.reps);
}

class UserProgressTableCompanion extends UpdateCompanion<UserProgressRow> {
  final Value<String> itemId;
  final Value<String> languageCode;
  final Value<double> stability;
  final Value<double> difficulty;
  final Value<DateTime> lastReview;
  final Value<DateTime> dueAt;
  final Value<int> lapses;
  final Value<int> reps;
  final Value<int> rowid;
  const UserProgressTableCompanion({
    this.itemId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.lapses = const Value.absent(),
    this.reps = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProgressTableCompanion.insert({
    required String itemId,
    required String languageCode,
    required double stability,
    required double difficulty,
    required DateTime lastReview,
    required DateTime dueAt,
    this.lapses = const Value.absent(),
    this.reps = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : itemId = Value(itemId),
        languageCode = Value(languageCode),
        stability = Value(stability),
        difficulty = Value(difficulty),
        lastReview = Value(lastReview),
        dueAt = Value(dueAt);
  static Insertable<UserProgressRow> custom({
    Expression<String>? itemId,
    Expression<String>? languageCode,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<DateTime>? lastReview,
    Expression<DateTime>? dueAt,
    Expression<int>? lapses,
    Expression<int>? reps,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (languageCode != null) 'language_code': languageCode,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (lastReview != null) 'last_review': lastReview,
      if (dueAt != null) 'due_at': dueAt,
      if (lapses != null) 'lapses': lapses,
      if (reps != null) 'reps': reps,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProgressTableCompanion copyWith(
      {Value<String>? itemId,
      Value<String>? languageCode,
      Value<double>? stability,
      Value<double>? difficulty,
      Value<DateTime>? lastReview,
      Value<DateTime>? dueAt,
      Value<int>? lapses,
      Value<int>? reps,
      Value<int>? rowid}) {
    return UserProgressTableCompanion(
      itemId: itemId ?? this.itemId,
      languageCode: languageCode ?? this.languageCode,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      lastReview: lastReview ?? this.lastReview,
      dueAt: dueAt ?? this.dueAt,
      lapses: lapses ?? this.lapses,
      reps: reps ?? this.reps,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressTableCompanion(')
          ..write('itemId: $itemId, ')
          ..write('languageCode: $languageCode, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('lastReview: $lastReview, ')
          ..write('dueAt: $dueAt, ')
          ..write('lapses: $lapses, ')
          ..write('reps: $reps, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LanguagesTable languages = $LanguagesTable(this);
  late final $ContentBundlesTable contentBundles = $ContentBundlesTable(this);
  late final $UnitsTable units = $UnitsTable(this);
  late final $GrammarNotesTable grammarNotes = $GrammarNotesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $GrammarNoteExamplesTable grammarNoteExamples =
      $GrammarNoteExamplesTable(this);
  late final $ItemTagsTable itemTags = $ItemTagsTable(this);
  late final $UserProgressTableTable userProgressTable =
      $UserProgressTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        languages,
        contentBundles,
        units,
        grammarNotes,
        items,
        grammarNoteExamples,
        itemTags,
        userProgressTable
      ];
}

typedef $$LanguagesTableCreateCompanionBuilder = LanguagesCompanion Function({
  required String code,
  required String name,
  required String nativeName,
  required Tier tier,
  Value<bool> hasCuratedContent,
  Value<bool> hasTts,
  Value<bool> hasAsr,
  Value<bool> hasPronunciationScoring,
  Value<bool> llmCorpusConstrained,
  required Script script,
  Value<bool> rtl,
  Value<String?> ttsVoiceHint,
  Value<int> rowid,
});
typedef $$LanguagesTableUpdateCompanionBuilder = LanguagesCompanion Function({
  Value<String> code,
  Value<String> name,
  Value<String> nativeName,
  Value<Tier> tier,
  Value<bool> hasCuratedContent,
  Value<bool> hasTts,
  Value<bool> hasAsr,
  Value<bool> hasPronunciationScoring,
  Value<bool> llmCorpusConstrained,
  Value<Script> script,
  Value<bool> rtl,
  Value<String?> ttsVoiceHint,
  Value<int> rowid,
});

final class $$LanguagesTableReferences
    extends BaseReferences<_$AppDatabase, $LanguagesTable, LanguageRow> {
  $$LanguagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserProgressTableTable, List<UserProgressRow>>
      _userProgressTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userProgressTable,
              aliasName: 'languages__code__user_progress_table__language_code');

  $$UserProgressTableTableProcessedTableManager get userProgressTableRefs {
    final manager =
        $$UserProgressTableTableTableManager($_db, $_db.userProgressTable)
            .filter((f) =>
                f.languageCode.code.sqlEquals($_itemColumn<String>('code')!));

    final cache =
        $_typedResult.readTableOrNull(_userProgressTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LanguagesTableFilterComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nativeName => $composableBuilder(
      column: $table.nativeName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Tier, Tier, String> get tier =>
      $composableBuilder(
          column: $table.tier,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get hasCuratedContent => $composableBuilder(
      column: $table.hasCuratedContent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasTts => $composableBuilder(
      column: $table.hasTts, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasAsr => $composableBuilder(
      column: $table.hasAsr, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasPronunciationScoring => $composableBuilder(
      column: $table.hasPronunciationScoring,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get llmCorpusConstrained => $composableBuilder(
      column: $table.llmCorpusConstrained,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Script, Script, String> get script =>
      $composableBuilder(
          column: $table.script,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get rtl => $composableBuilder(
      column: $table.rtl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ttsVoiceHint => $composableBuilder(
      column: $table.ttsVoiceHint, builder: (column) => ColumnFilters(column));

  Expression<bool> userProgressTableRefs(
      Expression<bool> Function($$UserProgressTableTableFilterComposer f) f) {
    final $$UserProgressTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.code,
        referencedTable: $db.userProgressTable,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProgressTableTableFilterComposer(
              $db: $db,
              $table: $db.userProgressTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LanguagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nativeName => $composableBuilder(
      column: $table.nativeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasCuratedContent => $composableBuilder(
      column: $table.hasCuratedContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasTts => $composableBuilder(
      column: $table.hasTts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasAsr => $composableBuilder(
      column: $table.hasAsr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasPronunciationScoring => $composableBuilder(
      column: $table.hasPronunciationScoring,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get llmCorpusConstrained => $composableBuilder(
      column: $table.llmCorpusConstrained,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get script => $composableBuilder(
      column: $table.script, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get rtl => $composableBuilder(
      column: $table.rtl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ttsVoiceHint => $composableBuilder(
      column: $table.ttsVoiceHint,
      builder: (column) => ColumnOrderings(column));
}

class $$LanguagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nativeName => $composableBuilder(
      column: $table.nativeName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Tier, String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<bool> get hasCuratedContent => $composableBuilder(
      column: $table.hasCuratedContent, builder: (column) => column);

  GeneratedColumn<bool> get hasTts =>
      $composableBuilder(column: $table.hasTts, builder: (column) => column);

  GeneratedColumn<bool> get hasAsr =>
      $composableBuilder(column: $table.hasAsr, builder: (column) => column);

  GeneratedColumn<bool> get hasPronunciationScoring => $composableBuilder(
      column: $table.hasPronunciationScoring, builder: (column) => column);

  GeneratedColumn<bool> get llmCorpusConstrained => $composableBuilder(
      column: $table.llmCorpusConstrained, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Script, String> get script =>
      $composableBuilder(column: $table.script, builder: (column) => column);

  GeneratedColumn<bool> get rtl =>
      $composableBuilder(column: $table.rtl, builder: (column) => column);

  GeneratedColumn<String> get ttsVoiceHint => $composableBuilder(
      column: $table.ttsVoiceHint, builder: (column) => column);

  Expression<T> userProgressTableRefs<T extends Object>(
      Expression<T> Function($$UserProgressTableTableAnnotationComposer a) f) {
    final $$UserProgressTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.code,
            referencedTable: $db.userProgressTable,
            getReferencedColumn: (t) => t.languageCode,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserProgressTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userProgressTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LanguagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LanguagesTable,
    LanguageRow,
    $$LanguagesTableFilterComposer,
    $$LanguagesTableOrderingComposer,
    $$LanguagesTableAnnotationComposer,
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (LanguageRow, $$LanguagesTableReferences),
    LanguageRow,
    PrefetchHooks Function({bool userProgressTableRefs})> {
  $$LanguagesTableTableManager(_$AppDatabase db, $LanguagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LanguagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LanguagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LanguagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> nativeName = const Value.absent(),
            Value<Tier> tier = const Value.absent(),
            Value<bool> hasCuratedContent = const Value.absent(),
            Value<bool> hasTts = const Value.absent(),
            Value<bool> hasAsr = const Value.absent(),
            Value<bool> hasPronunciationScoring = const Value.absent(),
            Value<bool> llmCorpusConstrained = const Value.absent(),
            Value<Script> script = const Value.absent(),
            Value<bool> rtl = const Value.absent(),
            Value<String?> ttsVoiceHint = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LanguagesCompanion(
            code: code,
            name: name,
            nativeName: nativeName,
            tier: tier,
            hasCuratedContent: hasCuratedContent,
            hasTts: hasTts,
            hasAsr: hasAsr,
            hasPronunciationScoring: hasPronunciationScoring,
            llmCorpusConstrained: llmCorpusConstrained,
            script: script,
            rtl: rtl,
            ttsVoiceHint: ttsVoiceHint,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String code,
            required String name,
            required String nativeName,
            required Tier tier,
            Value<bool> hasCuratedContent = const Value.absent(),
            Value<bool> hasTts = const Value.absent(),
            Value<bool> hasAsr = const Value.absent(),
            Value<bool> hasPronunciationScoring = const Value.absent(),
            Value<bool> llmCorpusConstrained = const Value.absent(),
            required Script script,
            Value<bool> rtl = const Value.absent(),
            Value<String?> ttsVoiceHint = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LanguagesCompanion.insert(
            code: code,
            name: name,
            nativeName: nativeName,
            tier: tier,
            hasCuratedContent: hasCuratedContent,
            hasTts: hasTts,
            hasAsr: hasAsr,
            hasPronunciationScoring: hasPronunciationScoring,
            llmCorpusConstrained: llmCorpusConstrained,
            script: script,
            rtl: rtl,
            ttsVoiceHint: ttsVoiceHint,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LanguagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userProgressTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userProgressTableRefs) db.userProgressTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userProgressTableRefs)
                    await $_getPrefetchedData<LanguageRow, $LanguagesTable,
                            UserProgressRow>(
                        currentTable: table,
                        referencedTable: $$LanguagesTableReferences
                            ._userProgressTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LanguagesTableReferences(db, table, p0)
                                .userProgressTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.languageCode == item.code),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LanguagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LanguagesTable,
    LanguageRow,
    $$LanguagesTableFilterComposer,
    $$LanguagesTableOrderingComposer,
    $$LanguagesTableAnnotationComposer,
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (LanguageRow, $$LanguagesTableReferences),
    LanguageRow,
    PrefetchHooks Function({bool userProgressTableRefs})>;
typedef $$ContentBundlesTableCreateCompanionBuilder = ContentBundlesCompanion
    Function({
  required String languageCode,
  required int schemaVersion,
  required String contentVersion,
  required String checksum,
  Value<int> rowid,
});
typedef $$ContentBundlesTableUpdateCompanionBuilder = ContentBundlesCompanion
    Function({
  Value<String> languageCode,
  Value<int> schemaVersion,
  Value<String> contentVersion,
  Value<String> checksum,
  Value<int> rowid,
});

final class $$ContentBundlesTableReferences extends BaseReferences<
    _$AppDatabase, $ContentBundlesTable, ContentBundleRow> {
  $$ContentBundlesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UnitsTable, List<UnitRow>> _unitsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.units,
          aliasName: 'content_bundles__language_code__units__language_code');

  $$UnitsTableProcessedTableManager get unitsRefs {
    final manager = $$UnitsTableTableManager($_db, $_db.units).filter((f) => f
        .languageCode.languageCode
        .sqlEquals($_itemColumn<String>('language_code')!));

    final cache = $_typedResult.readTableOrNull(_unitsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContentBundlesTableFilterComposer
    extends Composer<_$AppDatabase, $ContentBundlesTable> {
  $$ContentBundlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentVersion => $composableBuilder(
      column: $table.contentVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checksum => $composableBuilder(
      column: $table.checksum, builder: (column) => ColumnFilters(column));

  Expression<bool> unitsRefs(
      Expression<bool> Function($$UnitsTableFilterComposer f) f) {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableFilterComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContentBundlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentBundlesTable> {
  $$ContentBundlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentVersion => $composableBuilder(
      column: $table.contentVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checksum => $composableBuilder(
      column: $table.checksum, builder: (column) => ColumnOrderings(column));
}

class $$ContentBundlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentBundlesTable> {
  $$ContentBundlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => column);

  GeneratedColumn<String> get contentVersion => $composableBuilder(
      column: $table.contentVersion, builder: (column) => column);

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  Expression<T> unitsRefs<T extends Object>(
      Expression<T> Function($$UnitsTableAnnotationComposer a) f) {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableAnnotationComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContentBundlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContentBundlesTable,
    ContentBundleRow,
    $$ContentBundlesTableFilterComposer,
    $$ContentBundlesTableOrderingComposer,
    $$ContentBundlesTableAnnotationComposer,
    $$ContentBundlesTableCreateCompanionBuilder,
    $$ContentBundlesTableUpdateCompanionBuilder,
    (ContentBundleRow, $$ContentBundlesTableReferences),
    ContentBundleRow,
    PrefetchHooks Function({bool unitsRefs})> {
  $$ContentBundlesTableTableManager(
      _$AppDatabase db, $ContentBundlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentBundlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentBundlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentBundlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> languageCode = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<String> contentVersion = const Value.absent(),
            Value<String> checksum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentBundlesCompanion(
            languageCode: languageCode,
            schemaVersion: schemaVersion,
            contentVersion: contentVersion,
            checksum: checksum,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String languageCode,
            required int schemaVersion,
            required String contentVersion,
            required String checksum,
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentBundlesCompanion.insert(
            languageCode: languageCode,
            schemaVersion: schemaVersion,
            contentVersion: contentVersion,
            checksum: checksum,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ContentBundlesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({unitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (unitsRefs) db.units],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (unitsRefs)
                    await $_getPrefetchedData<ContentBundleRow,
                            $ContentBundlesTable, UnitRow>(
                        currentTable: table,
                        referencedTable:
                            $$ContentBundlesTableReferences._unitsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContentBundlesTableReferences(db, table, p0)
                                .unitsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.languageCode == item.languageCode),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContentBundlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContentBundlesTable,
    ContentBundleRow,
    $$ContentBundlesTableFilterComposer,
    $$ContentBundlesTableOrderingComposer,
    $$ContentBundlesTableAnnotationComposer,
    $$ContentBundlesTableCreateCompanionBuilder,
    $$ContentBundlesTableUpdateCompanionBuilder,
    (ContentBundleRow, $$ContentBundlesTableReferences),
    ContentBundleRow,
    PrefetchHooks Function({bool unitsRefs})>;
typedef $$UnitsTableCreateCompanionBuilder = UnitsCompanion Function({
  required String id,
  required String languageCode,
  required String title,
  Value<Cefr?> level,
  required int position,
  Value<int> rowid,
});
typedef $$UnitsTableUpdateCompanionBuilder = UnitsCompanion Function({
  Value<String> id,
  Value<String> languageCode,
  Value<String> title,
  Value<Cefr?> level,
  Value<int> position,
  Value<int> rowid,
});

final class $$UnitsTableReferences
    extends BaseReferences<_$AppDatabase, $UnitsTable, UnitRow> {
  $$UnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContentBundlesTable _languageCodeTable(_$AppDatabase db) =>
      db.contentBundles
          .createAlias('units__language_code__content_bundles__language_code');

  $$ContentBundlesTableProcessedTableManager get languageCode {
    final $_column = $_itemColumn<String>('language_code')!;

    final manager = $$ContentBundlesTableTableManager($_db, $_db.contentBundles)
        .filter((f) => f.languageCode.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_languageCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GrammarNotesTable, List<GrammarNoteRow>>
      _grammarNotesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.grammarNotes,
              aliasName: 'units__id__grammar_notes__unit_id');

  $$GrammarNotesTableProcessedTableManager get grammarNotesRefs {
    final manager = $$GrammarNotesTableTableManager($_db, $_db.grammarNotes)
        .filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_grammarNotesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ItemsTable, List<ItemRow>> _itemsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.items,
          aliasName: 'units__id__items__unit_id');

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Cefr?, Cefr, String> get level =>
      $composableBuilder(
          column: $table.level,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  $$ContentBundlesTableFilterComposer get languageCode {
    final $$ContentBundlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.contentBundles,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContentBundlesTableFilterComposer(
              $db: $db,
              $table: $db.contentBundles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> grammarNotesRefs(
      Expression<bool> Function($$GrammarNotesTableFilterComposer f) f) {
    final $$GrammarNotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.grammarNotes,
        getReferencedColumn: (t) => t.unitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNotesTableFilterComposer(
              $db: $db,
              $table: $db.grammarNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> itemsRefs(
      Expression<bool> Function($$ItemsTableFilterComposer f) f) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.unitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  $$ContentBundlesTableOrderingComposer get languageCode {
    final $$ContentBundlesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.contentBundles,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContentBundlesTableOrderingComposer(
              $db: $db,
              $table: $db.contentBundles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Cefr?, String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$ContentBundlesTableAnnotationComposer get languageCode {
    final $$ContentBundlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.contentBundles,
        getReferencedColumn: (t) => t.languageCode,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContentBundlesTableAnnotationComposer(
              $db: $db,
              $table: $db.contentBundles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> grammarNotesRefs<T extends Object>(
      Expression<T> Function($$GrammarNotesTableAnnotationComposer a) f) {
    final $$GrammarNotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.grammarNotes,
        getReferencedColumn: (t) => t.unitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNotesTableAnnotationComposer(
              $db: $db,
              $table: $db.grammarNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> itemsRefs<T extends Object>(
      Expression<T> Function($$ItemsTableAnnotationComposer a) f) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.unitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UnitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UnitsTable,
    UnitRow,
    $$UnitsTableFilterComposer,
    $$UnitsTableOrderingComposer,
    $$UnitsTableAnnotationComposer,
    $$UnitsTableCreateCompanionBuilder,
    $$UnitsTableUpdateCompanionBuilder,
    (UnitRow, $$UnitsTableReferences),
    UnitRow,
    PrefetchHooks Function(
        {bool languageCode, bool grammarNotesRefs, bool itemsRefs})> {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<Cefr?> level = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UnitsCompanion(
            id: id,
            languageCode: languageCode,
            title: title,
            level: level,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String languageCode,
            required String title,
            Value<Cefr?> level = const Value.absent(),
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              UnitsCompanion.insert(
            id: id,
            languageCode: languageCode,
            title: title,
            level: level,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UnitsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {languageCode = false,
              grammarNotesRefs = false,
              itemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (grammarNotesRefs) db.grammarNotes,
                if (itemsRefs) db.items
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (languageCode) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.languageCode,
                    referencedTable:
                        $$UnitsTableReferences._languageCodeTable(db),
                    referencedColumn: $$UnitsTableReferences
                        ._languageCodeTable(db)
                        .languageCode,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (grammarNotesRefs)
                    await $_getPrefetchedData<UnitRow, $UnitsTable,
                            GrammarNoteRow>(
                        currentTable: table,
                        referencedTable:
                            $$UnitsTableReferences._grammarNotesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UnitsTableReferences(db, table, p0)
                                .grammarNotesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.unitId == item.id),
                        typedResults: items),
                  if (itemsRefs)
                    await $_getPrefetchedData<UnitRow, $UnitsTable, ItemRow>(
                        currentTable: table,
                        referencedTable:
                            $$UnitsTableReferences._itemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UnitsTableReferences(db, table, p0).itemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.unitId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UnitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UnitsTable,
    UnitRow,
    $$UnitsTableFilterComposer,
    $$UnitsTableOrderingComposer,
    $$UnitsTableAnnotationComposer,
    $$UnitsTableCreateCompanionBuilder,
    $$UnitsTableUpdateCompanionBuilder,
    (UnitRow, $$UnitsTableReferences),
    UnitRow,
    PrefetchHooks Function(
        {bool languageCode, bool grammarNotesRefs, bool itemsRefs})>;
typedef $$GrammarNotesTableCreateCompanionBuilder = GrammarNotesCompanion
    Function({
  required String id,
  required String unitId,
  required String title,
  required String body,
  required int position,
  Value<int> rowid,
});
typedef $$GrammarNotesTableUpdateCompanionBuilder = GrammarNotesCompanion
    Function({
  Value<String> id,
  Value<String> unitId,
  Value<String> title,
  Value<String> body,
  Value<int> position,
  Value<int> rowid,
});

final class $$GrammarNotesTableReferences
    extends BaseReferences<_$AppDatabase, $GrammarNotesTable, GrammarNoteRow> {
  $$GrammarNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('grammar_notes__unit_id__units__id');

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$UnitsTableTableManager($_db, $_db.units)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GrammarNoteExamplesTable,
      List<GrammarNoteExampleRow>> _grammarNoteExamplesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.grammarNoteExamples,
          aliasName: 'grammar_notes__id__grammar_note_examples__note_id');

  $$GrammarNoteExamplesTableProcessedTableManager get grammarNoteExamplesRefs {
    final manager =
        $$GrammarNoteExamplesTableTableManager($_db, $_db.grammarNoteExamples)
            .filter((f) => f.noteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_grammarNoteExamplesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GrammarNotesTableFilterComposer
    extends Composer<_$AppDatabase, $GrammarNotesTable> {
  $$GrammarNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableFilterComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> grammarNoteExamplesRefs(
      Expression<bool> Function($$GrammarNoteExamplesTableFilterComposer f) f) {
    final $$GrammarNoteExamplesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.grammarNoteExamples,
        getReferencedColumn: (t) => t.noteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNoteExamplesTableFilterComposer(
              $db: $db,
              $table: $db.grammarNoteExamples,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GrammarNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrammarNotesTable> {
  $$GrammarNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableOrderingComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrammarNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrammarNotesTable> {
  $$GrammarNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableAnnotationComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> grammarNoteExamplesRefs<T extends Object>(
      Expression<T> Function($$GrammarNoteExamplesTableAnnotationComposer a)
          f) {
    final $$GrammarNoteExamplesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.grammarNoteExamples,
            getReferencedColumn: (t) => t.noteId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrammarNoteExamplesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.grammarNoteExamples,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$GrammarNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrammarNotesTable,
    GrammarNoteRow,
    $$GrammarNotesTableFilterComposer,
    $$GrammarNotesTableOrderingComposer,
    $$GrammarNotesTableAnnotationComposer,
    $$GrammarNotesTableCreateCompanionBuilder,
    $$GrammarNotesTableUpdateCompanionBuilder,
    (GrammarNoteRow, $$GrammarNotesTableReferences),
    GrammarNoteRow,
    PrefetchHooks Function({bool unitId, bool grammarNoteExamplesRefs})> {
  $$GrammarNotesTableTableManager(_$AppDatabase db, $GrammarNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrammarNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrammarNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrammarNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> unitId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GrammarNotesCompanion(
            id: id,
            unitId: unitId,
            title: title,
            body: body,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String unitId,
            required String title,
            required String body,
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              GrammarNotesCompanion.insert(
            id: id,
            unitId: unitId,
            title: title,
            body: body,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GrammarNotesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {unitId = false, grammarNoteExamplesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (grammarNoteExamplesRefs) db.grammarNoteExamples
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (unitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.unitId,
                    referencedTable:
                        $$GrammarNotesTableReferences._unitIdTable(db),
                    referencedColumn:
                        $$GrammarNotesTableReferences._unitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (grammarNoteExamplesRefs)
                    await $_getPrefetchedData<GrammarNoteRow,
                            $GrammarNotesTable, GrammarNoteExampleRow>(
                        currentTable: table,
                        referencedTable: $$GrammarNotesTableReferences
                            ._grammarNoteExamplesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GrammarNotesTableReferences(db, table, p0)
                                .grammarNoteExamplesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.noteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GrammarNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GrammarNotesTable,
    GrammarNoteRow,
    $$GrammarNotesTableFilterComposer,
    $$GrammarNotesTableOrderingComposer,
    $$GrammarNotesTableAnnotationComposer,
    $$GrammarNotesTableCreateCompanionBuilder,
    $$GrammarNotesTableUpdateCompanionBuilder,
    (GrammarNoteRow, $$GrammarNotesTableReferences),
    GrammarNoteRow,
    PrefetchHooks Function({bool unitId, bool grammarNoteExamplesRefs})>;
typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  required String id,
  required String unitId,
  required ItemType type,
  required String target,
  required String native,
  Value<String?> audioRef,
  Value<String?> altSpelling,
  Value<String?> furigana,
  Value<String?> pinyin,
  Value<String?> pitchAccent,
  Value<String?> note,
  required int position,
  Value<int> rowid,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<String> id,
  Value<String> unitId,
  Value<ItemType> type,
  Value<String> target,
  Value<String> native,
  Value<String?> audioRef,
  Value<String?> altSpelling,
  Value<String?> furigana,
  Value<String?> pinyin,
  Value<String?> pitchAccent,
  Value<String?> note,
  Value<int> position,
  Value<int> rowid,
});

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, ItemRow> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('items__unit_id__units__id');

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$UnitsTableTableManager($_db, $_db.units)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GrammarNoteExamplesTable,
      List<GrammarNoteExampleRow>> _grammarNoteExamplesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.grammarNoteExamples,
          aliasName: 'items__id__grammar_note_examples__item_id');

  $$GrammarNoteExamplesTableProcessedTableManager get grammarNoteExamplesRefs {
    final manager =
        $$GrammarNoteExamplesTableTableManager($_db, $_db.grammarNoteExamples)
            .filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_grammarNoteExamplesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ItemTagsTable, List<ItemTagRow>>
      _itemTagsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.itemTags,
              aliasName: 'items__id__item_tags__item_id');

  $$ItemTagsTableProcessedTableManager get itemTagsRefs {
    final manager = $$ItemTagsTableTableManager($_db, $_db.itemTags)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemTagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserProgressTableTable, List<UserProgressRow>>
      _userProgressTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.userProgressTable,
              aliasName: 'items__id__user_progress_table__item_id');

  $$UserProgressTableTableProcessedTableManager get userProgressTableRefs {
    final manager =
        $$UserProgressTableTableTableManager($_db, $_db.userProgressTable)
            .filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userProgressTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ItemType, ItemType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get target => $composableBuilder(
      column: $table.target, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get native => $composableBuilder(
      column: $table.native, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioRef => $composableBuilder(
      column: $table.audioRef, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get altSpelling => $composableBuilder(
      column: $table.altSpelling, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get furigana => $composableBuilder(
      column: $table.furigana, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinyin => $composableBuilder(
      column: $table.pinyin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pitchAccent => $composableBuilder(
      column: $table.pitchAccent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableFilterComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> grammarNoteExamplesRefs(
      Expression<bool> Function($$GrammarNoteExamplesTableFilterComposer f) f) {
    final $$GrammarNoteExamplesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.grammarNoteExamples,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNoteExamplesTableFilterComposer(
              $db: $db,
              $table: $db.grammarNoteExamples,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> itemTagsRefs(
      Expression<bool> Function($$ItemTagsTableFilterComposer f) f) {
    final $$ItemTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemTags,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemTagsTableFilterComposer(
              $db: $db,
              $table: $db.itemTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> userProgressTableRefs(
      Expression<bool> Function($$UserProgressTableTableFilterComposer f) f) {
    final $$UserProgressTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userProgressTable,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProgressTableTableFilterComposer(
              $db: $db,
              $table: $db.userProgressTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get target => $composableBuilder(
      column: $table.target, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get native => $composableBuilder(
      column: $table.native, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioRef => $composableBuilder(
      column: $table.audioRef, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get altSpelling => $composableBuilder(
      column: $table.altSpelling, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get furigana => $composableBuilder(
      column: $table.furigana, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinyin => $composableBuilder(
      column: $table.pinyin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pitchAccent => $composableBuilder(
      column: $table.pitchAccent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableOrderingComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ItemType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<String> get native =>
      $composableBuilder(column: $table.native, builder: (column) => column);

  GeneratedColumn<String> get audioRef =>
      $composableBuilder(column: $table.audioRef, builder: (column) => column);

  GeneratedColumn<String> get altSpelling => $composableBuilder(
      column: $table.altSpelling, builder: (column) => column);

  GeneratedColumn<String> get furigana =>
      $composableBuilder(column: $table.furigana, builder: (column) => column);

  GeneratedColumn<String> get pinyin =>
      $composableBuilder(column: $table.pinyin, builder: (column) => column);

  GeneratedColumn<String> get pitchAccent => $composableBuilder(
      column: $table.pitchAccent, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unitId,
        referencedTable: $db.units,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UnitsTableAnnotationComposer(
              $db: $db,
              $table: $db.units,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> grammarNoteExamplesRefs<T extends Object>(
      Expression<T> Function($$GrammarNoteExamplesTableAnnotationComposer a)
          f) {
    final $$GrammarNoteExamplesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.grammarNoteExamples,
            getReferencedColumn: (t) => t.itemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GrammarNoteExamplesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.grammarNoteExamples,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> itemTagsRefs<T extends Object>(
      Expression<T> Function($$ItemTagsTableAnnotationComposer a) f) {
    final $$ItemTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemTags,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.itemTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> userProgressTableRefs<T extends Object>(
      Expression<T> Function($$UserProgressTableTableAnnotationComposer a) f) {
    final $$UserProgressTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userProgressTable,
            getReferencedColumn: (t) => t.itemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserProgressTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userProgressTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemsTable,
    ItemRow,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (ItemRow, $$ItemsTableReferences),
    ItemRow,
    PrefetchHooks Function(
        {bool unitId,
        bool grammarNoteExamplesRefs,
        bool itemTagsRefs,
        bool userProgressTableRefs})> {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> unitId = const Value.absent(),
            Value<ItemType> type = const Value.absent(),
            Value<String> target = const Value.absent(),
            Value<String> native = const Value.absent(),
            Value<String?> audioRef = const Value.absent(),
            Value<String?> altSpelling = const Value.absent(),
            Value<String?> furigana = const Value.absent(),
            Value<String?> pinyin = const Value.absent(),
            Value<String?> pitchAccent = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsCompanion(
            id: id,
            unitId: unitId,
            type: type,
            target: target,
            native: native,
            audioRef: audioRef,
            altSpelling: altSpelling,
            furigana: furigana,
            pinyin: pinyin,
            pitchAccent: pitchAccent,
            note: note,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String unitId,
            required ItemType type,
            required String target,
            required String native,
            Value<String?> audioRef = const Value.absent(),
            Value<String?> altSpelling = const Value.absent(),
            Value<String?> furigana = const Value.absent(),
            Value<String?> pinyin = const Value.absent(),
            Value<String?> pitchAccent = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsCompanion.insert(
            id: id,
            unitId: unitId,
            type: type,
            target: target,
            native: native,
            audioRef: audioRef,
            altSpelling: altSpelling,
            furigana: furigana,
            pinyin: pinyin,
            pitchAccent: pitchAccent,
            note: note,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ItemsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {unitId = false,
              grammarNoteExamplesRefs = false,
              itemTagsRefs = false,
              userProgressTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (grammarNoteExamplesRefs) db.grammarNoteExamples,
                if (itemTagsRefs) db.itemTags,
                if (userProgressTableRefs) db.userProgressTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (unitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.unitId,
                    referencedTable: $$ItemsTableReferences._unitIdTable(db),
                    referencedColumn:
                        $$ItemsTableReferences._unitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (grammarNoteExamplesRefs)
                    await $_getPrefetchedData<ItemRow, $ItemsTable,
                            GrammarNoteExampleRow>(
                        currentTable: table,
                        referencedTable: $$ItemsTableReferences
                            ._grammarNoteExamplesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0)
                                .grammarNoteExamplesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (itemTagsRefs)
                    await $_getPrefetchedData<ItemRow, $ItemsTable, ItemTagRow>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._itemTagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).itemTagsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (userProgressTableRefs)
                    await $_getPrefetchedData<ItemRow, $ItemsTable,
                            UserProgressRow>(
                        currentTable: table,
                        referencedTable: $$ItemsTableReferences
                            ._userProgressTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0)
                                .userProgressTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemsTable,
    ItemRow,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (ItemRow, $$ItemsTableReferences),
    ItemRow,
    PrefetchHooks Function(
        {bool unitId,
        bool grammarNoteExamplesRefs,
        bool itemTagsRefs,
        bool userProgressTableRefs})>;
typedef $$GrammarNoteExamplesTableCreateCompanionBuilder
    = GrammarNoteExamplesCompanion Function({
  required String noteId,
  required String itemId,
  required int position,
  Value<int> rowid,
});
typedef $$GrammarNoteExamplesTableUpdateCompanionBuilder
    = GrammarNoteExamplesCompanion Function({
  Value<String> noteId,
  Value<String> itemId,
  Value<int> position,
  Value<int> rowid,
});

final class $$GrammarNoteExamplesTableReferences extends BaseReferences<
    _$AppDatabase, $GrammarNoteExamplesTable, GrammarNoteExampleRow> {
  $$GrammarNoteExamplesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GrammarNotesTable _noteIdTable(_$AppDatabase db) => db.grammarNotes
      .createAlias('grammar_note_examples__note_id__grammar_notes__id');

  $$GrammarNotesTableProcessedTableManager get noteId {
    final $_column = $_itemColumn<String>('note_id')!;

    final manager = $$GrammarNotesTableTableManager($_db, $_db.grammarNotes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('grammar_note_examples__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GrammarNoteExamplesTableFilterComposer
    extends Composer<_$AppDatabase, $GrammarNoteExamplesTable> {
  $$GrammarNoteExamplesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  $$GrammarNotesTableFilterComposer get noteId {
    final $$GrammarNotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.grammarNotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNotesTableFilterComposer(
              $db: $db,
              $table: $db.grammarNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrammarNoteExamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrammarNoteExamplesTable> {
  $$GrammarNoteExamplesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  $$GrammarNotesTableOrderingComposer get noteId {
    final $$GrammarNotesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.grammarNotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNotesTableOrderingComposer(
              $db: $db,
              $table: $db.grammarNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrammarNoteExamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrammarNoteExamplesTable> {
  $$GrammarNoteExamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$GrammarNotesTableAnnotationComposer get noteId {
    final $$GrammarNotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.noteId,
        referencedTable: $db.grammarNotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GrammarNotesTableAnnotationComposer(
              $db: $db,
              $table: $db.grammarNotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GrammarNoteExamplesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GrammarNoteExamplesTable,
    GrammarNoteExampleRow,
    $$GrammarNoteExamplesTableFilterComposer,
    $$GrammarNoteExamplesTableOrderingComposer,
    $$GrammarNoteExamplesTableAnnotationComposer,
    $$GrammarNoteExamplesTableCreateCompanionBuilder,
    $$GrammarNoteExamplesTableUpdateCompanionBuilder,
    (GrammarNoteExampleRow, $$GrammarNoteExamplesTableReferences),
    GrammarNoteExampleRow,
    PrefetchHooks Function({bool noteId, bool itemId})> {
  $$GrammarNoteExamplesTableTableManager(
      _$AppDatabase db, $GrammarNoteExamplesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrammarNoteExamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrammarNoteExamplesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrammarNoteExamplesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> noteId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GrammarNoteExamplesCompanion(
            noteId: noteId,
            itemId: itemId,
            position: position,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String noteId,
            required String itemId,
            required int position,
            Value<int> rowid = const Value.absent(),
          }) =>
              GrammarNoteExamplesCompanion.insert(
            noteId: noteId,
            itemId: itemId,
            position: position,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GrammarNoteExamplesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({noteId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (noteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.noteId,
                    referencedTable:
                        $$GrammarNoteExamplesTableReferences._noteIdTable(db),
                    referencedColumn: $$GrammarNoteExamplesTableReferences
                        ._noteIdTable(db)
                        .id,
                  ) as T;
                }
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable:
                        $$GrammarNoteExamplesTableReferences._itemIdTable(db),
                    referencedColumn: $$GrammarNoteExamplesTableReferences
                        ._itemIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GrammarNoteExamplesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GrammarNoteExamplesTable,
    GrammarNoteExampleRow,
    $$GrammarNoteExamplesTableFilterComposer,
    $$GrammarNoteExamplesTableOrderingComposer,
    $$GrammarNoteExamplesTableAnnotationComposer,
    $$GrammarNoteExamplesTableCreateCompanionBuilder,
    $$GrammarNoteExamplesTableUpdateCompanionBuilder,
    (GrammarNoteExampleRow, $$GrammarNoteExamplesTableReferences),
    GrammarNoteExampleRow,
    PrefetchHooks Function({bool noteId, bool itemId})>;
typedef $$ItemTagsTableCreateCompanionBuilder = ItemTagsCompanion Function({
  required String itemId,
  required String tag,
  Value<int> rowid,
});
typedef $$ItemTagsTableUpdateCompanionBuilder = ItemTagsCompanion Function({
  Value<String> itemId,
  Value<String> tag,
  Value<int> rowid,
});

final class $$ItemTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemTagsTable, ItemTagRow> {
  $$ItemTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('item_tags__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemTagsTable,
    ItemTagRow,
    $$ItemTagsTableFilterComposer,
    $$ItemTagsTableOrderingComposer,
    $$ItemTagsTableAnnotationComposer,
    $$ItemTagsTableCreateCompanionBuilder,
    $$ItemTagsTableUpdateCompanionBuilder,
    (ItemTagRow, $$ItemTagsTableReferences),
    ItemTagRow,
    PrefetchHooks Function({bool itemId})> {
  $$ItemTagsTableTableManager(_$AppDatabase db, $ItemTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemId = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemTagsCompanion(
            itemId: itemId,
            tag: tag,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String itemId,
            required String tag,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemTagsCompanion.insert(
            itemId: itemId,
            tag: tag,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ItemTagsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable: $$ItemTagsTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$ItemTagsTableReferences._itemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemTagsTable,
    ItemTagRow,
    $$ItemTagsTableFilterComposer,
    $$ItemTagsTableOrderingComposer,
    $$ItemTagsTableAnnotationComposer,
    $$ItemTagsTableCreateCompanionBuilder,
    $$ItemTagsTableUpdateCompanionBuilder,
    (ItemTagRow, $$ItemTagsTableReferences),
    ItemTagRow,
    PrefetchHooks Function({bool itemId})>;
typedef $$UserProgressTableTableCreateCompanionBuilder
    = UserProgressTableCompanion Function({
  required String itemId,
  required String languageCode,
  required double stability,
  required double difficulty,
  required DateTime lastReview,
  required DateTime dueAt,
  Value<int> lapses,
  Value<int> reps,
  Value<int> rowid,
});
typedef $$UserProgressTableTableUpdateCompanionBuilder
    = UserProgressTableCompanion Function({
  Value<String> itemId,
  Value<String> languageCode,
  Value<double> stability,
  Value<double> difficulty,
  Value<DateTime> lastReview,
  Value<DateTime> dueAt,
  Value<int> lapses,
  Value<int> reps,
  Value<int> rowid,
});

final class $$UserProgressTableTableReferences extends BaseReferences<
    _$AppDatabase, $UserProgressTableTable, UserProgressRow> {
  $$UserProgressTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$AppDatabase db) =>
      db.items.createAlias('user_progress_table__item_id__items__id');

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LanguagesTable _languageCodeTable(_$AppDatabase db) => db.languages
      .createAlias('user_progress_table__language_code__languages__code');

  $$LanguagesTableProcessedTableManager get languageCode {
    final $_column = $_itemColumn<String>('language_code')!;

    final manager = $$LanguagesTableTableManager($_db, $_db.languages)
        .filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_languageCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
      column: $table.dueAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LanguagesTableFilterComposer get languageCode {
    final $$LanguagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.code,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableFilterComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
      column: $table.dueAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LanguagesTableOrderingComposer get languageCode {
    final $$LanguagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.code,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableOrderingComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LanguagesTableAnnotationComposer get languageCode {
    final $$LanguagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.languageCode,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.code,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableAnnotationComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProgressTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProgressTableTable,
    UserProgressRow,
    $$UserProgressTableTableFilterComposer,
    $$UserProgressTableTableOrderingComposer,
    $$UserProgressTableTableAnnotationComposer,
    $$UserProgressTableTableCreateCompanionBuilder,
    $$UserProgressTableTableUpdateCompanionBuilder,
    (UserProgressRow, $$UserProgressTableTableReferences),
    UserProgressRow,
    PrefetchHooks Function({bool itemId, bool languageCode})> {
  $$UserProgressTableTableTableManager(
      _$AppDatabase db, $UserProgressTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProgressTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemId = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<double> stability = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<DateTime> lastReview = const Value.absent(),
            Value<DateTime> dueAt = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProgressTableCompanion(
            itemId: itemId,
            languageCode: languageCode,
            stability: stability,
            difficulty: difficulty,
            lastReview: lastReview,
            dueAt: dueAt,
            lapses: lapses,
            reps: reps,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String itemId,
            required String languageCode,
            required double stability,
            required double difficulty,
            required DateTime lastReview,
            required DateTime dueAt,
            Value<int> lapses = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProgressTableCompanion.insert(
            itemId: itemId,
            languageCode: languageCode,
            stability: stability,
            difficulty: difficulty,
            lastReview: lastReview,
            dueAt: dueAt,
            lapses: lapses,
            reps: reps,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserProgressTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({itemId = false, languageCode = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable:
                        $$UserProgressTableTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$UserProgressTableTableReferences._itemIdTable(db).id,
                  ) as T;
                }
                if (languageCode) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.languageCode,
                    referencedTable: $$UserProgressTableTableReferences
                        ._languageCodeTable(db),
                    referencedColumn: $$UserProgressTableTableReferences
                        ._languageCodeTable(db)
                        .code,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserProgressTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProgressTableTable,
    UserProgressRow,
    $$UserProgressTableTableFilterComposer,
    $$UserProgressTableTableOrderingComposer,
    $$UserProgressTableTableAnnotationComposer,
    $$UserProgressTableTableCreateCompanionBuilder,
    $$UserProgressTableTableUpdateCompanionBuilder,
    (UserProgressRow, $$UserProgressTableTableReferences),
    UserProgressRow,
    PrefetchHooks Function({bool itemId, bool languageCode})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db, _db.languages);
  $$ContentBundlesTableTableManager get contentBundles =>
      $$ContentBundlesTableTableManager(_db, _db.contentBundles);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$GrammarNotesTableTableManager get grammarNotes =>
      $$GrammarNotesTableTableManager(_db, _db.grammarNotes);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$GrammarNoteExamplesTableTableManager get grammarNoteExamples =>
      $$GrammarNoteExamplesTableTableManager(_db, _db.grammarNoteExamples);
  $$ItemTagsTableTableManager get itemTags =>
      $$ItemTagsTableTableManager(_db, _db.itemTags);
  $$UserProgressTableTableTableManager get userProgressTable =>
      $$UserProgressTableTableTableManager(_db, _db.userProgressTable);
}
