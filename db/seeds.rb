#encoding: utf-8

factory = RGeo::Geographic.spherical_factory(:srid => 4326)

paseo_dominical=Trip.create(
  :coordinates => "POINT(-99.17533053485674 19.42335931770571)",
  :name => "Paseo dominical", 
  :details => "Cada domingo de 8 AM a 2 PM",
  :picture_name => "paseo_dominical",
  :periodicity => Trip.build_timing_from_params(:day_timing => 0, :recurrence_timing => 2))

path_one=factory.parse_wkt('LINESTRING(-99.17533053485674 19.42335931770571, -99.17512056184364 19.42341005162402, -99.1746158266503 19.42364630906133, -99.1718856320899 19.42495259770773, -99.17165609148137 19.42485708207688, -99.17143526012303 19.42496138660346, -99.17133722666412 19.4252602600782, -99.16818255739081 19.42673755409997, -99.16757069521867 19.42658489258155, -99.16733803245155 19.42672622747217, -99.16725825641646 19.42711237118937, -99.16402099798606 19.42869555093417, -99.16362057353632 19.42859536078594, -99.16328502589886 19.42891121873786, -99.16317832087339 19.42907971547692, -99.15925841613945 19.43097991146099, -99.15892964037992 19.43099319063225, -99.15850922722689 19.43124204413526, -99.15805210539173 19.43151894263566, -99.15524441375555 19.43281590377821, -99.15464333008951 19.43279679793298, -99.15433851021147 19.4329624383642, -99.15415579166277 19.43339545708548, -99.14997753499891 19.43530353504886, -99.14962649671877 19.43529753461182, -99.14922658548298 19.4355179789416, -99.14899484135731 19.43578924016468, -99.14803726607727 19.43641620035179, -99.146616691826 19.43731802978666, -99.14600218510974 19.43780026749184, -99.14361977113842 19.43997215732068, -99.14310527482681 19.44031338256818, -99.14270844876199 19.44079213551459, -99.14151507123493 19.44193568568, -99.14053379700636 19.44284165797638, -99.13982996188821 19.44351120228389, -99.13926055669438 19.44369038141995, -99.13897016759357 19.44412205019017, -99.13874870555262 19.44440378464102, -99.13852024202937 19.44473656427945, -99.13802157907273 19.44517245385302, -99.13503820554834 19.44778699276084, -99.13462748416759 19.44808914723744, -99.13422438999054 19.44860602475651, -99.1340103900351 19.44895728957331, -99.13330340802894 19.44992737374096, -99.1310927914239 19.45271722489882, -99.13000151933583 19.45404706058766, -99.12813098470352 19.45686028168191, -99.12377485628792 19.46791328234957, -99.1185286208533 19.48140458286016, -99.11966515841634 19.48085072810482, -99.12070665632083 19.47973737648734, -99.12749607840186 19.46155249289249, -99.12970588599504 19.45603602714293, -99.13052028280133 19.45418795837546, -99.13087499811432 19.4533852297231, -99.13155215016342 19.45247531486258, -99.13443378014777 19.4487833662321, -99.13509631844008 19.44809301043352, -99.13877645429419 19.44470554112063, -99.13932083702488 19.44447137226313, -99.13966771798165 19.44413766475707, -99.13985752966822 19.44377517528786, -99.1400487383049 19.44353585208381, -99.14290644242234 19.44096674880065, -99.14335474795168 19.44060294983375, -99.14365198481174 19.44017066428351, -99.14654064794973 19.43763701588589, -99.14694063512592 19.43731072950526, -99.14902644723534 19.43596825118538, -99.14952070072393 19.435759795991, -99.14997954454368 19.43546775842818, -99.15050093191535 19.43518095625687, -99.15421872366012 19.43346895181169, -99.15464402474737 19.43334444308146, -99.15503991775671 19.43322465059122, -99.15519896123783 19.4329578563344, -99.15543925545639 19.43283083926516, -99.15847652047842 19.43142703574259, -99.15880466644327 19.43135741442921, -99.15916604110963 19.43121050523489, -99.15942337466933 19.43100291347208, -99.16020809069732 19.43062522133516, -99.1633255006742 19.42917436421893, -99.16370051074577 19.4292434022521, -99.16395288148321 19.42911170622294, -99.16408123414543 19.42886586819336, -99.16418411357957 19.42872694178836, -99.16726154151441 19.42728327456645, -99.16755575470937 19.42745899076037, -99.16790481212263 19.42743635770477, -99.16812398387846 19.42716897350258, -99.16822642596581 19.42683001078457, -99.17138881515046 19.4253673640614, -99.17160480937294 19.42540036665121, -99.17181719865495 19.42536111604841, -99.17191399531094 19.42517008994972, -99.17210221732816 19.42495153529887, -99.17511043879298 19.42355102298784, -99.17527199359498 19.42340131668694)')
path_two=factory.parse_wkt('LINESTRING(-99.14948886258931 19.43533096403626, -99.1483849636501 19.43533799161168, -99.14573239745638 19.43501648582986, -99.14183228236932 19.43437766995994, -99.14218898153302 19.43215553522982, -99.12826605138761 19.43020690914775, -99.12743328800362 19.4360046849067, -99.12947065017703 19.43631738178194, -99.13018201354996 19.4314177842639, -99.14109638567805 19.43280159474909, -99.14292932884216 19.43306913060939, -99.14268787582921 19.43443216419266, -99.14264832545616 19.43461006032432, -99.14623357470424 19.43521423229928, -99.14810629121246 19.43539586542866, -99.1491144714138 19.43562864993982)')

Segment.create(
  :color => "#1f3a50",
  :path => path_one,
  :details => "Trazo sobre reforma, de chapultepec a basílica",
  :trip_id => paseo_dominical.id)
  
Segment.create(
  :color => "#1f3a50",
  :path => path_two,
  :details => "Trazo pasando por el primer cuadro del centro histórico",
  :trip_id => paseo_dominical.id)

TripPoi.create(
  :name => "Punto recomendado de Arranque de la Ruta",
  :category => TripPoi.category_for(:categories, :start_flag),
  :coordinates => factory.parse_wkt('POINT(-99.166489 19.427401)'),
  :trip_id => paseo_dominical.id
)

# Préstamo de bicis
TripPoi.create(
  :name => "Cerca de la glorieta de la palma",
  :category => TripPoi.category_for(:categories, :bike_lending),
  :coordinates => factory.parse_wkt('POINT(-99.163435 19.429229)'),
  :trip_id => paseo_dominical.id
)

# Estaciones de servicio
TripPoi.create(
  :name => "Fuente de la Diana",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Estación de Servicio</li><li>Paseo a Ciegas</li><li>Clases de Yoga</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.171395 19.424860)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Ángel de la Independencia",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Estación de Servicio</li><li>Muévete y Métete en Cintura</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :free_grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.167061 19.426762)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Glorieta de la Palma",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Atención Médica</li><li>Estación de Servicio</li><li>Préstamo de Bicicletas</li><li>Préstamo de Remolques</li><li>Muévete y Métete en Cintura</li><li>Locatel</li><li>Clases de Yoga</li></ul>",
  :category => TripPoi.category_for(:categories, :grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.163327 19.428664)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Monumento a Cuauhtémoc",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Préstamo de Bicicletas</li><li>Estación de Servicio</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.159422 19.430930)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Peralvillo",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Atención Médica</li><li>Préstamo de Bicicletas</li><li>Estación de Servicio</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :free_grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.130046 19.453699)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "La Villa",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Atención Médica</li><li>Estación de Servicio</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :free_grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.122729 19.474593)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Plaza Loreto",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Atención Médica</li><li>Estación de Servicio</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :free_grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.127321 19.435792)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Fuente Bicentenario",
  :details => "<p>Cuenta con los siguientes servicios:</p><ul><li>Baño</li><li>Atención Médica</li><li>Estación de Servicio</li><li>Préstamo de Bicicletas</li><li>Locatel</li></ul>",
  :category => TripPoi.category_for(:categories, :free_grouped_services),
  :coordinates => factory.parse_wkt('POINT(-99.148564 19.435220)'),
  :trip_id => paseo_dominical.id
)

TripPoi.create(
  :name => "Bicientrénate",
  :details => "Aprende a moverte en bici en la ciudad. Cerca de Lieja, frente a la Torre Mayor",
  :category => TripPoi.category_for(:categories, :cycling_learning),
  :coordinates => factory.parse_wkt('POINT(-99.174399 19.423605)'),
  :trip_id => paseo_dominical.id
)

#Stations
TripPoi.create(
  :name => "Sevilla",
  :details => "Metro Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.170607 19.421926)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_sevilla"
)

TripPoi.create(
  :name => "Hamburgo",
  :details => "Metrobús Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.160838 19.428242)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_hamburgo"
)

TripPoi.create(
  :name => "Reforma",
  :details => "Metrobús Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.158758 19.432834)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_reforma"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metrobús Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147148 19.435989)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_hidalgo"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.145625 19.437252)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_hidalgo"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metro Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.146622 19.437191)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_hidalgo"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147245 19.437323)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_hidalgo"
)

TripPoi.create(
  :name => "Juárez",
  :details => "Metro Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147631 19.433367)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_juarez"
)

TripPoi.create(
  :name => "San Juan de Letrán",
  :details => "Metro Línea 8",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.141269 19.431179)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_san_juan_de_letran"
)

TripPoi.create(
  :name => "Zócalo",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.132106 19.432939)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_zocalo"
)

TripPoi.create(
  :name => "Bellas Artes",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.141655 19.436232)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_bellas_artes"
)

TripPoi.create(
  :name => "Bellas Artes",
  :details => "Metrobus Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.141140 19.436353)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_bellas_artes"
)

TripPoi.create(
  :name => "Allende",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.136934 19.435625)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_allende"
)

TripPoi.create(
  :name => "Glorieta de Colón",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.153414 19.434308)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_glorieta_de_colon"
)

TripPoi.create(
  :name => "Eje Central",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.141440 19.430311)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_eje_central"
)

TripPoi.create(
  :name => "República del Salvador",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.138908 19.429977)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_republica_del_salvador"
)

TripPoi.create(
  :name => "Isabel la Católica",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.136838 19.429643)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_isabel_la_catolica"
)

TripPoi.create(
  :name => "Museo de la Ciudad",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.134756 19.429390)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_museo_de_la_ciudad"
)

TripPoi.create(
  :name => "Las Cruces Norte",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.129403 19.428649)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_las_cruces_norte"
)

TripPoi.create(
  :name => "Teatro del Pueblo",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.127321 19.436844)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_teatro_del_pueblo"
)

TripPoi.create(
  :name => "Museo de la Ciudad",
  :details => "Metrobús Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.134756 19.429390)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metrobus_museo_de_la_ciudad"
)

TripPoi.create(
  :name => "La Villa-Basílica",
  :details => "Metro Línea 6",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.118094 19.481456)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_villa_basilica"
)

TripPoi.create(
  :name => "Misterios",
  :details => "Metro Línea 5",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.131162 19.463087)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_misterios"
)

TripPoi.create(
  :name => "Garibaldi-Lagunilla",
  :details => "Metro Línea 8",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.139252 19.442733)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_garibaldi"
)

TripPoi.create(
  :name => "Garibaldi-Lagunilla",
  :details => "Metro Línea B",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.139810 19.444412)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_garibaldi"
)

TripPoi.create(
  :name => "Chapultepec",
  :details => "Metro Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.176245 19.420838)'),
  :trip_id => paseo_dominical.id,
  :icon_name => "metro_chapultepec"
)

# Ciclotón
cicloton=Trip.create(
  :coordinates => "POINT(-99.166489 19.427401)",
  :name => "Ciclotón", 
  :details => "Último domingo del mes de 8 AM a 2 PM",
  :picture_name => "cicloton",
  :periodicity => Trip.build_timing_from_params(:day_timing => 0, :recurrence_timing => 1, :ocurrence_timing => -1))

path=factory.parse_wkt('LINESTRING(-99.166489 19.427401, -99.149300 19.435493, -99.141815 19.434351, -99.142204 19.432135, -99.130302 19.430487, -99.130920 19.426235, -99.130722 19.425558, -99.131042 19.423403, -99.128059 19.423090, -99.122459 19.422352, -99.120308 19.422068, -99.115074 19.420692, -99.112183 19.419912, -99.113609 19.405706, -99.098442 19.408903, -99.097946 19.408579, -99.097588 19.407488, -99.097801 19.404816, -99.100891 19.382814, -99.102097 19.373867, -99.102654 19.372248, -99.104370 19.371033, -99.105782 19.370222, -99.108231 19.370102, -99.123978 19.369171, -99.125267 19.368361, -99.126129 19.367105, -99.131706 19.357794, -99.132690 19.356781, -99.133980 19.356457, -99.169769 19.358603, -99.173203 19.360344, -99.180283 19.367512, -99.186249 19.371639, -99.187149 19.372732, -99.187149 19.374271, -99.186935 19.375566, -99.183037 19.385242, -99.182686 19.386497, -99.181915 19.393177, -99.180199 19.399694, -99.178055 19.405645, -99.179871 19.409145, -99.174873 19.418091, -99.168198 19.419548, -99.168671 19.422503, -99.168945 19.423149, -99.166374 19.424343, -99.167381 19.426510, -99.167084 19.427116, -99.166458 19.427401)')

Segment.create(
  :color => "#1f3a50",
  :path => path,
  :details => "Trazo de recorrido",
  :trip_id => cicloton.id)

# Préstamo de bicis
TripPoi.create(
  :name => "Cerca de la glorieta de la palma",
  :category => TripPoi.category_for(:categories, :bike_lending),
  :coordinates => factory.parse_wkt('POINT(-99.163435 19.429229)'),
  :trip_id => cicloton.id
)

# Estaciones de servicio
TripPoi.create(
  :name => "Estación 1",
  :details => "Reforma y Niza",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.163475 19.428751)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 2",
  :details => "Juárez y Luis Moya",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.144859 19.434862)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 3",
  :details => "Eje 3 Francisco del Paso Troncoso y Av. del taller",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.112892 19.413731)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 4",
  :details => "Río Churubusco y Canela",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.099083 19.397894)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 5",
  :details => "Río Churubusco y Contralores",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.111397 19.369991)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 6",
  :details => "Río Churubusco y División del Norte",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.153564 19.357876)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 7",
  :details => "Río Mixcoac y Barranca del Muerto",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.177704 19.365223)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 8",
  :details => "Patriotismo y Calle 25",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.182777 19.386084)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Estación 9",
  :details => "Diagonal Patriotismo y Sombrerete",
  :category => TripPoi.category_for(:categories, :service_station),
  :coordinates => factory.parse_wkt('POINT(-99.179314 19.408224)'),
  :trip_id => cicloton.id
)

# Paramédicos
TripPoi.create(
  :details => "Patriotismo y Tintoreto",
  :category => TripPoi.category_for(:categories, :paramedic),
  :coordinates => factory.parse_wkt('POINT(-99.183648 19.383254)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :details => "Diagonal Patriotismo y Mazatlán",
  :category => TripPoi.category_for(:categories, :paramedic),
  :coordinates => factory.parse_wkt('POINT(-99.179549 19.408695)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :details => "Fray Servando Teresa de Mier y Congreso de la Unión",
  :category => TripPoi.category_for(:categories, :paramedic),
  :coordinates => factory.parse_wkt('POINT(-99.120562 19.422113)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :details => "Eje 3 ote y Río Churubusco",
  :category => TripPoi.category_for(:categories, :paramedic),
  :coordinates => factory.parse_wkt('POINT(-99.105542 19.370684)'),
  :trip_id => cicloton.id
)

#Kilometros

TripPoi.create(
  :name => "Km. 5",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.126034 19.422943)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Km. 10",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.097881 19.404582)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Km. 15",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.112601 19.369767)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Km. 20",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.153757 19.357691)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Km. 25",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.180965 19.396896)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Km. 30",
  :category => TripPoi.category_for(:categories, :km_mark),
  :coordinates => factory.parse_wkt('POINT(-99.180965 19.396896)'),
  :trip_id => cicloton.id
)


# Ambulances
TripPoi.create(
  :category => TripPoi.category_for(:categories, :ambulance),
  :coordinates => factory.parse_wkt('POINT(-99.138179 19.356852)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :category => TripPoi.category_for(:categories, :ambulance),
  :coordinates => factory.parse_wkt('POINT(-99.162362 19.426284)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Punto de Arranque de la Ruta",
  :category => TripPoi.category_for(:categories, :start_flag),
  :coordinates => factory.parse_wkt('POINT(-99.166489 19.427401)'),
  :trip_id => cicloton.id
)

TripPoi.create(
  :name => "Punto de Termino de la Ruta",
  :category => TripPoi.category_for(:categories, :finish_flag),
  :coordinates => factory.parse_wkt('POINT(-99.166458 19.427401)'),
  :trip_id => cicloton.id
)

#Stations

TripPoi.create(
  :name => "Río Churubusco",
  :details => "Metrobús Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.180629 19.368666)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_churubusco"
)

TripPoi.create(
  :name => "Mixcoac",
  :details => "Metro Línea 7",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.187805 19.376164)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_mixcoac"
)

TripPoi.create(
  :name => "Mixcoac",
  :details => "Metro Línea 12",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.187188 19.376149)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_mixcoac"
)

TripPoi.create(
  :name => "San Antonio",
  :details => "Metro Línea 7",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.187805 19.376164)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_san_antonio"
)

TripPoi.create(
  :name => "Patriotismo",
  :details => "Metrobús Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.176352 19.405356)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_patriotismo"
)

TripPoi.create(
  :name => "Patriotismo",
  :details => "Metro Línea 9",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.178841 19.406247)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_patriotismo"
)

TripPoi.create(
  :name => "Sevilla",
  :details => "Metro Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.170607 19.421926)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_sevilla"
)

TripPoi.create(
  :name => "Hamburgo",
  :details => "Metrobús Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.160838 19.428242)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_hamburgo"
)

TripPoi.create(
  :name => "Reforma",
  :details => "Metrobús Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.158758 19.432834)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_reforma"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metrobús Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147148 19.435989)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_hidalgo"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metro Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.146622 19.437191)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_hidalgo"
)

TripPoi.create(
  :name => "Hidalgo",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147245 19.437323)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_hidalgo"
)

TripPoi.create(
  :name => "Juárez",
  :details => "Metro Línea 3",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.147631 19.433367)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_juarez"
)

TripPoi.create(
  :name => "San Juan de Letrán",
  :details => "Metro Línea 8",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.141269 19.431179)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_san_juan_de_letran"
)

TripPoi.create(
  :name => "Zócalo",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.132106 19.432939)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_zocalo"
)

TripPoi.create(
  :name => "Pino Suárez",
  :details => "Metro Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.133050 19.425351)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_pino_suarez"
)

TripPoi.create(
  :name => "Pino Suárez",
  :details => "Metro Línea 1",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.133201 19.426099)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_pino_suarez"
)

TripPoi.create(
  :name => "Fray Servando",
  :details => "Metro Línea 4",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.120476 19.421688)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_fray_servando"
)

TripPoi.create(
  :name => "Mixiuhca",
  :details => "Metro Línea 9",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.112859 19.408635)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_mixiuhca"
)

TripPoi.create(
  :name => "Velódromo",
  :details => "Metro Línea 9",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.102902 19.408189)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_velodromo"
)

TripPoi.create(
  :name => "Goma",
  :details => "Metrobús Línea 2",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.099641 19.396896)'),
  :trip_id => cicloton.id,
  :icon_name => "metrobus_goma"
)

TripPoi.create(
  :name => "Aculco",
  :details => "Metro Línea 8",
  :category => TripPoi.category_for(:categories, :transport_connection),
  :coordinates => factory.parse_wkt('POINT(-99.107752 19.373416)'),
  :trip_id => cicloton.id,
  :icon_name => "metro_aculco"
)

Tip.create([
{:content => "En Irapuato localizar a Irapuato en Bici excelente ambiente y grupo muy cálido sus guías tienen una ruta diferente cada vez. Tiene actividad de martes a domingo.", :category => 2, :likes_count => 0, :updated_at => "2013-09-04 20:00:22", :created_at => "2013-09-04 19:56:28", :coordinates => "POINT (-99.92669567538542 19.5382996892923)", :user_id => User.where(:username => 'Irapuatoenbici').first.id},
{:content => "Recien se crearon las ciclovias en los camellones laterales sobre. Extremar precauciones en los cruceros ya pasan por las salidas de desaceleracion de la carretera.", :category => 2, :likes_count => 0, :updated_at => "2013-08-31 15:49:24", :created_at => "2013-08-31 15:46:03", :coordinates => "POINT (-99.53852 19.28586)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "El último río de la ciudad, donde todavía viven patos y abunda la vegetación. Los domingos las familias van a pescar. ", :category => 3, :likes_count => 0, :updated_at => "2013-08-23 02:44:10", :created_at => "2013-08-23 02:42:38", :coordinates => "POINT (-99.127815 19.351206)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Uno de los últimos ríos vivos en la ciudad que se conservan en buen estado, a tal grado que tiene fauna viviendo en él. Hay mucha vegetación en los alrededores. ", :category => 3, :likes_count => 0, :updated_at => "2013-08-23 02:35:30", :created_at => "2013-05-18 01:52:36", :coordinates => "POINT (-9.912801E-05 1.9350971E-05)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Un bajo puente donde hay muchos restaurantes de comida corrida.", :category => 2, :likes_count => 0, :updated_at => "2013-07-19 15:32:10", :created_at => "2013-07-19 15:29:43", :coordinates => "POINT (-99.17607 19.423923)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Existe un semáforo peatonal en este punto que nunca ha funcionado, si vienes en bici o a pie hay que fijarse bien al cruzar, mucho tránsito. ", :category => 2, :likes_count => 0, :updated_at => "2013-07-12 11:47:20", :created_at => "2013-07-12 11:45:08", :coordinates => "POINT (-99.208405 19.43137)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Termina coclovía sin prevención alguna,  sales directo a la avenida a continuar por la calle entre los autos. ", :category => 1, :likes_count => 0, :updated_at => "2013-07-11 08:36:54", :created_at => "2013-07-11 08:34:39", :coordinates => "POINT (-103.35753 20.659842)", :user_id => User.where(:username => 'Ally1').first.id},
{:content => "Vista de lo que parece ser un típico conjunto habitacional social berlinés.", :category => 3, :likes_count => 0, :updated_at => "2013-07-10 14:14:57", :created_at => "2013-06-28 05:56:55", :coordinates => "POINT (13.359395 52.49306)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "El muro de John Lennon que es una especie de memorial y un espacio dónde se promueve la libertad de expresión ante regímenes autoritarios. Se puede llegar fácilmente en bicicleta. ", :category => 3, :likes_count => 0, :updated_at => "2013-07-10 14:14:32", :created_at => "2013-06-15 04:37:07", :coordinates => "POINT (14.406981 50.086143)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Un callejón muy pintoresco, típico de Praga que vale la pena visitar. Es fácil llegar en bicicleta.", :category => 3, :likes_count => 0, :updated_at => "2013-07-10 14:11:36", :created_at => "2013-06-14 09:57:24", :coordinates => "POINT (14.403998 50.086723)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Callejón en Gante con paredes llenas de grafittis. Muy recomendable!", :category => 3, :likes_count => 0, :updated_at => "2013-07-04 08:03:41", :created_at => "2013-06-05 10:12:45", :coordinates => "POINT (3.724689 51.055317)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Area Natural Protegida - Sierra Santa Catarina. Paque Ecologico. Es un Excelente lugar ara descansar mientras ruedas por la zona Oriente de la Ciudad. Cuenta con pita para correr y juegos para los niños.", :category => 3, :likes_count => 0, :updated_at => "2013-06-26 17:29:25", :created_at => "2013-06-26 17:29:25", :coordinates => "POINT (-98.97464822977781 19.310809223260893)", :user_id => User.where(:username => 'Gerard86').first.id},
{:content => "Extremar preacuciones, ser muy visibles, vehículos a alta velocidad. NO SE RESPETA ALGUNA PREFERENCIA.Circulan vehículos de carga y pasajeros.  ", :category => 1, :likes_count => 0, :updated_at => "2013-06-10 03:45:14", :created_at => "2013-06-10 03:45:14", :coordinates => "POINT (-99.1662947461009 19.529164939216418)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Recomiendo usar la lateral de \"Acueducto de Guadalupe\" es muy segura. ", :category => 2, :likes_count => 0, :updated_at => "2013-06-10 03:41:55", :created_at => "2013-06-10 03:41:55", :coordinates => "POINT (-99.1496928781271 19.52205631276372)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Crucero de alta peligrosidad, por cualquier lado. No confiarse de los semáforos ni de los policías de transito. Ser visible, extremar precauciones. ", :category => 1, :likes_count => 0, :updated_at => "2013-06-10 03:38:13", :created_at => "2013-06-10 03:38:13", :coordinates => "POINT (-99.12037532776594 19.422158729089347)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "De sur a norte se complica el paso, entrada y salida de carros, parada de camiones, base taxis y todo mundo quiere pasar primero. Ser visible y hacer ruido, manejar con extrema precaución. Pasando la plaza yace una bici blanca. ", :category => 1, :likes_count => 0, :updated_at => "2013-06-10 03:32:31", :created_at => "2013-06-10 03:32:31", :coordinates => "POINT (-99.17061410844326 19.361316119847235)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Ya sea de norte o sur, extremar precauciones. Ser muy visible, vehículos a alta velocidad. De sur a norte es bajada, revisar frenos y estar a tanto de todo.  ", :category => 1, :likes_count => 0, :updated_at => "2013-06-10 03:27:18", :created_at => "2013-06-10 03:27:18", :coordinates => "POINT (-99.18828651309013 19.32126823734918)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Desnivel. Ser visible y pegarse a la orilla, esta esta usualmente con basura y encharcada. Cuidado con lo baches.  ", :category => 2, :likes_count => 0, :updated_at => "2013-06-07 15:39:15", :created_at => "2013-06-07 15:39:15", :coordinates => "POINT (-99.13392417132854 19.417929223702142)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Ser visible, y extremar precauciones al cruzar. Recomiendo no usar la orilla si van a a cruzar mas de la mitad de la glorieta, tomar el carril inmediato a la derecha. Carros entran y salir a alta velocidad. Hacer  ruido y luz si es de noche.. ", :category => 2, :likes_count => 0, :updated_at => "2013-06-07 15:34:57", :created_at => "2013-06-07 15:34:57", :coordinates => "POINT (-99.15130488574505 19.392104593820985)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Sea cual sea el sentido que tomen extremen precauciones. Hay puestos, peatones cruzando sin fijarse, camiones, carros que se avientan para pasar y motonetas que hacen de las suyas. No ser muy llamativos, fluir con el ambiente. No caer en provocacones", :category => 1, :likes_count => 0, :updated_at => "2013-06-07 15:31:11", :created_at => "2013-06-07 15:31:11", :coordinates => "POINT (-99.12776581943035 19.443082030573855)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Si vas de oriente a poniente sobre eje 3 sur (Baja California), hay que tener mucho cuidado, ya que muchos autos dan vuelta a la derecha. Recomiendo esperar al semáforo y colocarse al frente para hacerse visible.", :category => 1, :likes_count => 0, :updated_at => "2013-05-31 19:37:09", :created_at => "2013-05-31 19:37:09", :coordinates => "POINT (-99.17799202725291 19.40590792333)", :user_id => User.where(:username => 'hectorfuentes').first.id},
{:content => "Para atravesar Tlalpan de poniente a oriente este desnivel es muy útil. Sólo ten cuidado de no circular muy pegado a la orilla por las coladeras.", :category => 2, :likes_count => 0, :updated_at => "2013-05-31 19:25:59", :created_at => "2013-05-31 19:25:59", :coordinates => "POINT (-99.13929848000407 19.38650804236533)", :user_id => User.where(:username => 'hectorfuentes').first.id},
{:content => "Para atravesar Tlalpan de oriente a poniente este desnivel es muy útil. Sólo ten cuidado de no circular muy pegado a la orilla por las coladeras. ", :category => 2, :likes_count => 0, :updated_at => "2013-05-31 02:21:27", :created_at => "2013-05-31 02:19:29", :coordinates => "POINT (-99.138016 19.39182)", :user_id => User.where(:username => 'hectorfuentes').first.id},
{:content => "Zona reducida para bicis, vehículos a alta velocidad y coladeras tanto pavimento en mal estado. PRECAUCIÓN ", :category => 1, :likes_count => 0, :updated_at => "2013-05-27 22:17:57", :created_at => "2013-05-27 22:16:06", :coordinates => "POINT (-99.112206 19.423166)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Hacerse visible, el desnivel está sucio y con charcos, aunque no sea tiempo de lluvia. En la curva precaución con los que vengan por atrás. No confiarse del carril del trolebus en todo el eje.", :category => 2, :likes_count => 0, :updated_at => "2013-05-27 21:46:55", :created_at => "2013-05-27 21:43:44", :coordinates => "POINT (-99.1354 19.413282)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "Es necesario extremar precauciones y hacerse visible. Entre camiones y carros se hace complicada la preferencia a la bicicleta.", :category => 1, :likes_count => 0, :updated_at => "2013-05-27 21:41:44", :created_at => "2013-05-27 21:39:10", :coordinates => "POINT (-99.17608 19.353241)", :user_id => User.where(:username => 'angel88mx').first.id},
{:content => "ciclovia invadida frecuentemente a la altura de sierra mazamitla", :category => 2, :likes_count => 0, :updated_at => "2013-05-24 17:31:24", :created_at => "2013-05-24 17:29:40", :coordinates => "POINT (-103.418106 20.61354)", :user_id => User.where(:username => 'Padbiker').first.id},
{:content => "Cuidado en el cruce cuando vayan sobre Orizaba. El pavimento es muy irregular. Reduzcan la velocidad.", :category => 1, :likes_count => 0, :updated_at => "2013-05-22 05:36:39", :created_at => "2013-05-22 05:36:39", :coordinates => "POINT (-99.15875639766455 19.414235905299513)", :user_id => User.where(:username => 'ztirzo').first.id},
{:content => "Aseguren bien sus bicis con candado y no solamente con cable. Esta zona de la Roma es donde más robos de bicis hay en todo el DF.", :category => 1, :likes_count => 0, :updated_at => "2013-05-22 05:33:36", :created_at => "2013-05-22 05:33:36", :coordinates => "POINT (-99.15976457297802 19.418293491655607)", :user_id => User.where(:username => 'ztirzo').first.id},
{:content => "Cuidado con los ambulantes y los peatones que invaden el carril bus-bici. Repórtenlos a @caspoliciadf", :category => 1, :likes_count => 0, :updated_at => "2013-05-22 05:31:51", :created_at => "2013-05-22 05:31:51", :coordinates => "POINT (-99.14248075336218 19.427015441594982)", :user_id => User.where(:username => 'ztirzo').first.id},
{:content => "Pasar por aquí en dirección sur-centro es una muy mala idea si no hay tráfico; los autos pasan muy rápido, hay coladeras destapadas y poca iluminación.", :category => 1, :likes_count => 0, :updated_at => "2013-05-21 10:59:02", :created_at => "2013-05-21 10:56:18", :coordinates => "POINT (-99.14335 19.34106)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "Recordarle a los policias del metro que tienen la obligación de abrir la puerta para meter la bicicleta rodando, y no tener que cargarla sobre los torniquetes!", :category => 2, :likes_count => 0, :updated_at => "2013-05-20 16:26:13", :created_at => "2013-05-20 16:26:13", :coordinates => "POINT (-99.08522129058838 19.356194264384797)", :user_id => User.where(:username => 'Hazael').first.id},
{:content => "Cerveza, Pulque, botana huarachitos para recuperar energia en la rodada.", :category => 3, :likes_count => 0, :updated_at => "2013-05-19 16:16:31", :created_at => "2013-05-19 16:13:49", :coordinates => "POINT (-98.98443 19.296688)", :user_id => User.where(:username => 'Gerard86').first.id},
{:content => "Trébol riesgoso, pasan muchos autobuses que van hacia estados cercanos. ", :category => 1, :likes_count => 0, :updated_at => "2013-05-19 12:37:51", :created_at => "2013-05-19 12:36:11", :coordinates => "POINT (-103.427086 20.614204)", :user_id => User.where(:username => 'vidriloco').first.id},
{:content => "En esta área se pueden apreciar a muchos ciclistas, es una zona tranquila con tráfico moderado y buenos cruces peatonales. ", :category => 2, :likes_count => 0, :updated_at => "2013-05-17 20:28:34", :created_at => "2013-05-17 20:26:35", :coordinates => "POINT (-103.36857 20.671396)", :user_id => User.where(:username => 'vidriloco').first.id}]) 

Workshop.create([
{:name => "Taller \"El Gato\"", :details => "Muy buen mecánico, siempre está lleno, da buen precio aunque a veces termina checando demasiadas cosas ", :store => false, :phone => 41525748, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-09-13 18:30:58", :created_at => "2013-06-06 17:51:46", :coordinates => "POINT (-99.11755 19.41881)"},
{:name => "928 Love Bike", :details => "Omar es mi mecánico de confianza. Da muy buen servicio y a precios súper accesibles!", :store => true, :phone => nil, :cell_phone => 44, :webpage => "https://www.facebook.com/LoveBike928bicipersonalizada?ref=ts&fref=ts", :twitter => "", :horary => "Martes a viernes de 10am a 6pm
Sábado y domingo de 12pm a 6pm
(creo...)", :likes_count => 0, :updated_at => "2013-08-22 22:37:37", :created_at => "2013-08-22 22:37:37", :coordinates => "POINT (-99.17353738099337 19.377105807720504)"},
{:name => "Sin nombre. ", :details => "Principalmente taller. Agustín Yañez esquina  Fernando López Portillo.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-08-14 11:53:13", :created_at => "2013-08-14 11:50:11", :coordinates => "POINT (-99.10996 19.364809)"},
{:name => "Bicycle Life Style", :details => "Tienda muy completa. Servicios y reparaciones. 
Tienda de bicicletas · Renta de bicicletas y bicicletas compartidas
Pitagoras 1263, Mexico City, MX.", :store => true, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "Lun - Sáb: 10:30 - 20:00", :likes_count => 0, :updated_at => "2013-06-30 03:26:10", :created_at => "2013-06-30 03:26:10", :coordinates => "POINT (-99.16119410656393 19.376971703031508)"},
{:name => "BICISERVICIO BICIVER", :details => "LUNES a SÁBADO 
7:30 18:00
Buen servicio. ----------/-//Explica  los procesos y técnicas que utiliza para reparar.
También es tienda.
Buenos precios. Reparaciones, servicio, pintura. 
Marco", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-20 11:50:18", :created_at => "2013-06-20 11:35:38", :coordinates => "POINT (-99.100876 19.430141)"},
{:name => "\"El negro\"", :details => "Refacciones muy básicas y parchado de llantas, te salva de un imprevisto ", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-20 09:03:31", :created_at => "2013-06-04 09:28:30", :coordinates => "POINT (-99.13656 19.416018)"},
{:name => "No tiene nombre. ", :details => "Pequeño taller pero muy eficientes y rápidos. Al lado de una papelería y casi frente una plaza pública. ", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-11 11:17:42", :created_at => "2013-06-11 11:15:42", :coordinates => "POINT (-99.12732 19.429783)"},
{:name => "Sin nombre", :details => "Local pequeño. Barato y rápido. No es muy notorio y esta algo sucio. Siempre hay bicicletas afuera.", :store => false, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "9- 18 hrs", :likes_count => 0, :updated_at => "2013-06-11 05:12:46", :created_at => "2013-06-11 05:12:46", :coordinates => "POINT (-99.11191153340042 19.34988535474193)"},
{:name => "Taller", :details => "No se nada del lugar, de hecho es poco visible, esta frente al Pollo Feliz, se ve informal ya que no tiene letrero ni nada. Afuera tiene muchos triciclos para reparación.", :store => false, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-11 03:59:46", :created_at => "2013-06-11 03:48:38", :coordinates => "POINT (-99.11172470077872 19.44547468314764)"},
{:name => "Taller Saldaña", :details => "Refacciones, pintura reparaciones 
Lunes a Sabado de 9hr a 17hrs. Domingo 9 a 15hrs. ", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "Lunes a Sabado de 9hr a 17hrs. Domingo 9 a 15hrs. ", :likes_count => 0, :updated_at => "2013-06-09 20:36:40", :created_at => "2013-06-05 13:56:59", :coordinates => "POINT (-99.16814 19.545773)"},
{:name => "Taller Nueva Tenochtitlan ", :details => "Mecánico de la vieja escuela el surtido de refacciones no es demasiado amplio, pero el señor da buenos precios en sus trabajos y sabe lo que está haciendo. ", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-04 20:42:13", :created_at => "2013-06-04 20:37:31", :coordinates => "POINT (-99.10544 19.454224)"},
{:name => "Taller Bici ", :details => "un pequeño taller de bicicletas. El señor es confiable y sabe lo que hace.", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-06-04 19:19:02", :created_at => "2013-06-04 19:16:59", :coordinates => "POINT (-99.15248 19.360006)"},
{:name => "Servicio Buendía", :details => "Buen servicio, rápido y honesto. Aunque es caro. Muy pocos productos más allá de refacciones.", :store => true, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 20:09:30", :created_at => "2013-05-31 20:09:30", :coordinates => "POINT (-99.12951378151774 19.408781783043302)"},
{:name => "Saints Bike", :details => "Muy buen taller, excelente trato. Los precios de sus productos no son excesivos.", :store => true, :phone => 0, :cell_phone => 39502423, :webpage => "", :twitter => "", :horary => "Lunes a Sábado de 12 a 19 hrs.", :likes_count => 0, :updated_at => "2013-05-31 19:47:14", :created_at => "2013-05-31 01:11:47", :coordinates => "POINT (-99.13459 19.395372)"},
{:name => "Bicimaníacos", :details => "Taller y tienda. Buen surtido en la tienda y marcas de gama media alta. Aunque creo que es caro, es comprensible por la zona.", :store => true, :phone => 55364651, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 19:43:35", :created_at => "2013-05-31 19:43:35", :coordinates => "POINT (-99.1480210237205 19.38819816046018)"},
{:name => "Bicicletas del Diablo", :details => "Es un taller con varios mecánicos, la tienda está bien surtida. ", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 13:50:29", :created_at => "2013-05-31 13:48:15", :coordinates => "POINT (-99.15024 19.398369)"},
{:name => "El Rápido", :details => "Taller mecánico y pintura. El surtido de refacciones es malo, además de ser caro. Sólo para urgencias.", :store => true, :phone => 55831100, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "Lunes a Sábado de 11 a 19 hrs", :likes_count => 0, :updated_at => "2013-05-31 07:11:41", :created_at => "2013-05-31 07:11:41", :coordinates => "POINT (-99.1317535042981 19.460467161569518)"},
{:name => "BENOTTO", :details => "Sólo es tienda. Medianamente surtida a pesar de ser de la cadena de tiendas. El servicio es regular.", :store => true, :phone => 56001108, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "Lunes a Domingo de 10 a 19 hrs.", :likes_count => 0, :updated_at => "2013-05-31 07:07:23", :created_at => "2013-05-31 07:07:23", :coordinates => "POINT (-99.06771308185853 19.377257624216334)"},
{:name => "GAROZZO", :details => "Principalmente es tienda, aunque también te arreglan tu bici si lo necesitas. La tienda muy surtida.", :store => true, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "Lunes a Domingo de 10 a 19 hrs.", :likes_count => 0, :updated_at => "2013-05-31 07:03:50", :created_at => "2013-05-31 07:03:50", :coordinates => "POINT (-99.06683707245975 19.376883143270714)"},
{:name => "Veloflash", :details => "Buen taller a secas. El mecánico es medio desidioso, así que no le dejes tu bici o se tarda mucho. Algo sutida la tienda.", :store => true, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "Martes a Domingo de 10 a 19 hrs.", :likes_count => 0, :updated_at => "2013-05-31 06:59:37", :created_at => "2013-05-31 06:59:37", :coordinates => "POINT (-99.05338060860231 19.375739452891597)"},
{:name => "Sin Nombre", :details => "No es muy bueno ni cuenta con muchas refacciones, pero te puede sacar de un apuro. ", :store => false, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 06:53:12", :created_at => "2013-05-31 06:53:03", :coordinates => "POINT (-99.08965480331972 19.475817335299517)"},
{:name => "Sin Nombre", :details => "A pesar de su aspecto, es un taller muy concurrido. El mecánico es bastante bueno, aunque casi no tiene refacciones.", :store => false, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 06:48:58", :created_at => "2013-05-31 06:48:58", :coordinates => "POINT (-99.11169183258608 19.445530325811056)"},
{:name => "El Balín", :details => "Buen taller, un poco caro. Muy surtida en refacciones y he pasado después de las 8 pm y lo he visto abierto.", :store => true, :phone => nil, :cell_phone => nil, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-31 06:45:06", :created_at => "2013-05-31 06:45:06", :coordinates => "POINT (-99.10531765224732 19.462232379071466)"},
{:name => "Servicio Buendía ", :details => "
Trabaja muy bien. Vende accesorios básicos y bajo pedido especializados, altamente recomendable.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-27 21:54:32", :created_at => "2013-05-27 21:53:02", :coordinates => "POINT (-99.107735 19.429146)"},
{:name => "Servicio Oviedo ", :details => "
Trabaja muy bien, no abre los Lunes. Vende accesorios básicos y bajo pedido especializados, altamente recomendable.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-27 21:52:56", :created_at => "2013-05-27 21:48:53", :coordinates => "POINT (-99.10687 19.428215)"},
{:name => "Los Gordos", :details => "Par de hermanos dueños y mecánicos del Taller. Son rapidos y son buenos para las reparaciones, también hacen pintura.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:00- 20:00", :likes_count => 0, :updated_at => "2013-05-27 14:16:41", :created_at => "2013-05-19 06:14:32", :coordinates => "POINT (-98.95280599594116 19.323784173301156)"},
{:name => "Sin Nombre", :details => "Mecanico disponible solamente medios dias,. Ya sea de las 9:00- 14:00 O de 14:00-20:00", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "9:00-20:00", :likes_count => 0, :updated_at => "2013-05-27 14:16:27", :created_at => "2013-05-19 06:17:45", :coordinates => "POINT (-98.94905090332031 19.3259558454159)"},
{:name => "La Mexico", :details => "Muy buena Atención y rapides. 000000000000000000000000000000000000000000", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:00- 18:00", :likes_count => 0, :updated_at => "2013-05-27 14:16:16", :created_at => "2013-05-19 06:22:25", :coordinates => "POINT (-98.95104378461838 19.319878634387898)"},
{:name => "Sin Nombre", :details => "Pequeño taller de bicicletas a un costado de la carretera Mex-Puebla. Cuenta con las piezas indispensables para la reparacion de tu bici", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:00-20:00", :likes_count => 0, :updated_at => "2013-05-27 14:16:05", :created_at => "2013-05-19 17:20:34", :coordinates => "POINT (-98.94031226634979 19.320341836687867)"},
{:name => "Sin Nombre", :details => "Pequeño Taller de bicicletas, venta de accesorios basicos.  0000000000000000000000000", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "09:00-20:00", :likes_count => 0, :updated_at => "2013-05-27 14:15:54", :created_at => "2013-05-19 17:24:54", :coordinates => "POINT (-98.92994821071625 19.314208729366076)"},
{:name => "Bicicletas MEdina", :details => "Gran tienda de Bicicletas y accesorios, mayoreo y menudeo. Taller Mecánico.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:00-18:00", :likes_count => 0, :updated_at => "2013-05-27 14:15:40", :created_at => "2013-05-19 17:32:19", :coordinates => "POINT (-98.93913477659225 19.301083663618144)"},
{:name => "Casa Tachira", :details => "Taller y refacciones,venta de MAyoreo y Menudeo. Pintura al horno", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "9:00-18:00", :likes_count => 0, :updated_at => "2013-05-27 14:15:25", :created_at => "2013-05-19 17:37:55", :coordinates => "POINT (-98.93878743052483 19.303010089266785)"},
{:name => "Sin Nombre", :details => "Venta de Bicicletas, taller y accesorios de todos los precios, pintura al horno.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "9:00-19:00", :likes_count => 0, :updated_at => "2013-05-27 14:15:02", :created_at => "2013-05-20 05:44:43", :coordinates => "POINT (-98.9731639623642 19.360898583305108)"},
{:name => "Ciclobici Buenrosto", :details => "Tienda de Bicicletas, taller y accesorios de todos los pecios, desde economicos hasta gama alta también en bicicletas. Pintura al horno", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:0-18:00", :likes_count => 0, :updated_at => "2013-05-27 14:14:41", :created_at => "2013-05-20 06:00:40", :coordinates => "POINT (-98.98500859737396 19.36665543227053)"},
{:name => "CicloVital", :details => "Pequeño taller de Cicicletas, cuenta con refacciones economicas. El viejito que atiende es algo malhumorado jajajajaja", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "10:00-20:00", :likes_count => 0, :updated_at => "2013-05-27 14:14:29", :created_at => "2013-05-20 06:06:39", :coordinates => "POINT (-98.96645843982697 19.31164455149002)"},
{:name => "Pedal Power", :details => "Servicio, reparación y mantenimiento. Pintura horneada, soldadura en general, reparacion de cuadros. venta de accesorios económicos y gama alta.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "09:00-19:00", :likes_count => 0, :updated_at => "2013-05-27 14:14:15", :created_at => "2013-05-20 06:13:12", :coordinates => "POINT (-99.01979148387909 19.29509919537681)"},
{:name => "La Bici Urbana", :details => "Tienda y taller de bicicletas especializada en movilidad para la ciudad.", :store => true, :phone => 55350240, :cell_phone => 0, :webpage => "https://www.facebook.com/labiciurbana", :twitter => "labiciurbana", :horary => "Lun - Sáb: 10:00 - 19:00
Dom: 9:00 - 15:00", :likes_count => 0, :updated_at => "2013-05-27 14:13:19", :created_at => "2013-05-20 21:16:17", :coordinates => "POINT (-99.15157914161682 19.432661187383577)"},
{:name => "People for Bikes", :details => "Muy buena tienda con gran surtido y trato muy amable, se especializan en la venta de la marca Specialized. ", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-27 09:43:20", :created_at => "2013-05-19 14:17:18", :coordinates => "POINT (-99.157005 19.416523)"},
{:name => "Moab bikes", :details => "opcion al sur de la ciudad, bicicletas accs y taller. casi todas las marcas", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-24 18:36:39", :created_at => "2013-05-24 18:35:00", :coordinates => "POINT (-103.429146 20.63157)"},
{:name => "Bicicletas Vazher", :details => "una de las más conocidas tiendas de bicletas en GDL... algo caro el taller", :store => false, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-24 18:33:13", :created_at => "2013-05-24 18:08:28", :coordinates => "POINT (-103.407486 20.662613)"},
{:name => "Casa ciclista", :details => "Gdl en bici A.C. Taller, escuela, hospedaje a cicloturistas, comunitario, etc.", :store => true, :phone => 0, :cell_phone => 0, :webpage => "", :twitter => "", :horary => "", :likes_count => 0, :updated_at => "2013-05-21 19:21:16", :created_at => "2013-05-21 19:16:51", :coordinates => "POINT (-103.36481 20.684294)"}]) 

Parking.create([
{:details => "Bici estacionamiento en Brujas Bélgica, hay muchos más de ellos a lo largo de esta calle, parecen seguros", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-04 06:51:49", :updated_at => "2013-07-10 14:16:41", :coordinates => "POINT (3.225753 51.213238)"},
{:details => "Estacionamiento pequeño para 3 bicis para el bar Primer Piso", :kind => 3, :has_roof => false, :likes_count => 0, :created_at => "2013-06-27 21:34:04", :updated_at => "2013-06-27 21:34:57", :coordinates => "POINT (-103.35875 20.67546)"},
{:details => "3 U's en esta cuadra, la calle siempre está transitada y hay policías cerca", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-25 16:52:40", :updated_at => "2013-06-25 16:54:35", :coordinates => "POINT (-99.13487 19.427565)"},
{:details => "Dentro de la FES Zacatlan. Buena altura y junto a vigilancia. Usen u lock", :kind => 3, :has_roof => true, :likes_count => 0, :created_at => "2013-06-17 11:59:44", :updated_at => "2013-06-17 12:00:39", :coordinates => "POINT (-99.18936 19.522297)"},
{:details => "Es comodo e ideal para candados en U.
Zona transitada.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-09 11:26:55", :updated_at => "2013-06-09 11:26:55", :coordinates => "POINT (-99.13926243782043 19.43457594100785)"},
{:details => "Para la tienda de CFE. Muy adecuado para candados de U y desde luego para los otros. ", :kind => 3, :has_roof => false, :likes_count => 0, :created_at => "2013-06-08 09:59:35", :updated_at => "2013-06-08 10:01:44", :coordinates => "POINT (-99.064644 19.376684)"},
{:details => "Muy cómodo, tiene 4 racks. Aunque no tiene vigilancia, rondan mucho los policías. ", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-05 11:44:15", :updated_at => "2013-06-05 21:23:24", :coordinates => "POINT (-99.13952999999998 19.432297)"},
{:details => "En espiral amplio. Frente a un café.  Muy a la vista. Está sobre la banqueta. ", :kind => 3, :has_roof => false, :likes_count => 0, :created_at => "2013-06-05 18:03:55", :updated_at => "2013-06-05 18:06:01", :coordinates => "POINT (-99.168686 19.410929)"},
{:details => "Dentro del estacionamiento de Galerías Coapa. Frente a la entrada a Liverpool.  Junto a las motos con vigilancia. ", :kind => 3, :has_roof => true, :likes_count => 0, :created_at => "2013-06-05 12:29:25", :updated_at => "2013-06-05 12:30:21", :coordinates => "POINT (-99.12336 19.3033)"},
{:details => "Entrando al estacionamiento de walmart miramontes. Es alto y muy a la vista.", :kind => 3, :has_roof => false, :likes_count => 0, :created_at => "2013-06-05 12:20:07", :updated_at => "2013-06-05 12:21:28", :coordinates => "POINT (-99.12466 19.317764)"},
{:details => "2 u's invertidas, mucha gente afuera de la latino al lado de la parada del trolebus ", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-04 17:15:01", :updated_at => "2013-06-04 17:16:40", :coordinates => "POINT (-99.14088 19.433817)"},
{:details => "Ocho racks, No cuenta con cámara pero siempre hay gente en el área. ", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-04 00:39:54", :updated_at => "2013-06-04 00:47:25", :coordinates => "POINT (-99.13396 19.416534)"},
{:details => "Es un estacionamiento al aire libre. No tiene vigilancia. Hay cómo 8 racks.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-06-03 16:22:18", :updated_at => "2013-06-03 16:23:46", :coordinates => "POINT (-99.15123 19.361204)"},
{:details => "No está dentro del metro, pero en la puerta. He visto que tiene cámara de vigilancia. Me atrevo a decir que es el más usado del país. Una excelente opción para combinar transportes y de mucha utilidad si vives en el Oriente de la Ciudad.", :kind => 1, :has_roof => true, :likes_count => 0, :created_at => "2013-05-31 20:19:14", :updated_at => "2013-05-31 20:19:14", :coordinates => "POINT (-99.07135276123881 19.415794192338407)"},
{:details => "Dentro del metro. Obviamente es muy seguro. Una excelente opción para combinar transportes y de mucha utilidad si vives en el Norte de la Ciudad.", :kind => 1, :has_roof => true, :likes_count => 0, :created_at => "2013-05-31 20:13:59", :updated_at => "2013-05-31 20:13:59", :coordinates => "POINT (-99.12657793611288 19.4837270383244)"},
{:details => "Dentro del metro, en la línea 6 (Roja). Obviamente es muy seguro. Una excelente opción para combinar transportes y de mucha utilidad si vives en el Norte de la Ciudad.", :kind => 1, :has_roof => true, :likes_count => 0, :created_at => "2013-05-31 20:12:46", :updated_at => "2013-05-31 20:12:46", :coordinates => "POINT (-99.1070636920631 19.482553756391958)"},
{:details => "Es del Metrobús, no cuenta con vigilancia, aunque hay cámara de vigilancia. Ideal sí no tardas mucho.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-31 01:05:17", :updated_at => "2013-05-31 01:07:42", :coordinates => "POINT (-99.1348 19.39358)"},
{:details => "son 15 U poco utilizadas dentro del \"Club Ciclista de la Ciudad de México\"", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-29 14:49:27", :updated_at => "2013-05-29 14:51:31", :coordinates => "POINT (-99.196526 19.417912)"},
{:details => "Bici-estacionamiento de la oficina de Freescale México, excelente lugar para trabajar en la industria de la tecnología incluyendo pequeñas motivaciones para pedalear al trabajo", :kind => 3, :has_roof => true, :likes_count => 0, :created_at => "2013-05-28 09:40:40", :updated_at => "2013-05-28 09:50:15", :coordinates => "POINT (-103.41039 20.611032)"},
{:details => "Para usuarios biblioteca", :kind => 3, :has_roof => true, :likes_count => 0, :created_at => "2013-05-26 20:03:04", :updated_at => "2013-05-26 20:03:04", :coordinates => "POINT (-99.15089450776577 19.446157569060766)"},
{:details => "Afuera del Hotel Brick. De todos modos aseguren bien sus bicis porque hay muchos robos por esta zona.", :kind => 3, :has_roof => false, :likes_count => 0, :created_at => "2013-05-22 05:07:43", :updated_at => "2013-05-22 05:07:43", :coordinates => "POINT (-99.16018333286047 19.41928510583723)"},
{:details => "Justo afuera de La Cafe de la Roma. Útil para ir a tomar un café o al parque.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-22 05:03:04", :updated_at => "2013-05-22 05:03:04", :coordinates => "POINT (-99.15622992441058 19.424728757542052)"},
{:details => "Justo frente a la entrada del Centro Cultural Telmex en la calle de Guaymas. Conveniente para visitar la plaza. Lugar concurrido por los restaurantes.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-22 05:00:41", :updated_at => "2013-05-22 05:00:41", :coordinates => "POINT (-99.15511948987842 19.425108187432805)"},
{:details => "Afuera de Aurrera Chapultepec sobre la banqueta hay barandales donde puedes amarrar la bici, solo ten cuidado de no estorbar el paso de los peatones. Asegurate que el barandal esté bien sujeto al suelo.", :kind => 2, :has_roof => false, :likes_count => 0, :created_at => "2013-05-21 16:18:00", :updated_at => "2013-05-21 16:18:00", :coordinates => "POINT (-103.37061491867644 20.67929554910307)"},
{:details => "Pertenece al gimnasio HD Sport Fitness, hay rumores de que se han robado bicicletas. ", :kind => 3, :has_roof => true, :likes_count => 0, :created_at => "2013-05-21 10:23:51", :updated_at => "2013-05-21 10:24:56", :coordinates => "POINT (-99.15369 19.424765)"},
{:details => "Amplio estacionamiento para bicis. Funciona sobre todo si vas al parque de Chapultepec, ya que está dentro de éste.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-19 14:10:15", :updated_at => "2013-05-19 14:10:15", :coordinates => "POINT (-99.17611598968506 19.423089610232022)"},
{:details => "Frente a una plaza que tiene muchos restaurantes bonitos desde los cuales se pueden ver las bicis.  ", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-17 21:10:56", :updated_at => "2013-05-17 21:13:48", :coordinates => "POINT (-103.36612 20.673046)"},
{:details => "Un estacionamiento seguro para dejar la bicicleta, parece ser de gobierno. ", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-17 19:09:05", :updated_at => "2013-05-17 19:13:13", :coordinates => "POINT (-103.36878 20.669134)"},
{:details => "Esta justo en la entrada de la Expo Guadalajara, parece ser un buen lugar para dejar la bici.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-17 18:20:36", :updated_at => "2013-05-17 18:22:07", :coordinates => "POINT (-103.3912 20.655111)"},
{:details => "Capacidad para 20 bicicletas. Esta fuera de la estación.", :kind => 1, :has_roof => false, :likes_count => 0, :created_at => "2013-05-16 23:35:37", :updated_at => "2013-05-16 23:35:37", :coordinates => "POINT (-99.14312481880188 19.3442696378921)"},
{:details => "Dentro de la esctación de metro, capacidad 16 bicicletas. ", :kind => 1, :has_roof => true, :likes_count => 0, :created_at => "2013-05-16 23:33:46", :updated_at => "2013-05-16 23:33:46", :coordinates => "POINT (-99.16272640228271 19.423615758084186)"}]) 

Ownership.create([
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (3.225753 51.213238)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'vidriloco').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.35875 20.67546)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'perrodeblues').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13487 19.427565)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.18936 19.522297)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Dragoncius').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13926243782043 19.43457594100785)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.064644 19.376684)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13952999999998 19.432297)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.168686 19.410929)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Dragoncius').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.12336 19.3033)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Dragoncius').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.12466 19.317764)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Dragoncius').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.14088 19.433817)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13396 19.416534)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15123 19.361204)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.07135276123881 19.415794192338407)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.12657793611288 19.4837270383244)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.1070636920631 19.482553756391958)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.1348 19.39358)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.196526 19.417912)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'tlacoyodefrijol').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.41039 20.611032)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'perrodeblues').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15089450776577 19.446157569060766)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.16018333286047 19.41928510583723)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'ztirzo').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15622992441058 19.424728757542052)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'ztirzo').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15511948987842 19.425108187432805)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'ztirzo').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.37061491867644 20.67929554910307)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'OpteronMx').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15369 19.424765)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'Hellerox').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.17611598968506 19.423089610232022)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'betun').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.36612 20.673046)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'vidriloco').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.36878 20.669134)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'vidriloco').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.3912 20.655111)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'vidriloco').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.14312481880188 19.3442696378921)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'biciayuda').first.id, :kind => 1},
{:owned_object_id => Parking.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.16272640228271 19.423615758084186)").first.id, :owned_object_type => 'Parking', :user_id => User.where(:username => 'biciayuda').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.11755 19.41881)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.17353738099337 19.377105807720504)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'JanyMA').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.10996 19.364809)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'FerSilva').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.16119410656393 19.376971703031508)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.100876 19.430141)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13656 19.416018)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.12732 19.429783)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'sir_rodrigogl').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.11191153340042 19.34988535474193)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'sir_rodrigogl').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.11172470077872 19.44547468314764)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.16814 19.545773)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.10544 19.454224)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Pvillan').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15248 19.360006)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'GerhardPrutz').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.12951378151774 19.408781783043302)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.13459 19.395372)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.1480210237205 19.38819816046018)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15024 19.398369)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.1317535042981 19.460467161569518)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.06771308185853 19.377257624216334)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.06683707245975 19.376883143270714)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.05338060860231 19.375739452891597)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.08965480331972 19.475817335299517)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.11169183258608 19.445530325811056)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.10531765224732 19.462232379071466)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'hectorfuentes').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.107735 19.429146)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.10687 19.428215)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'angel88mx').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.95280599594116 19.323784173301156)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.94905090332031 19.3259558454159)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.95104378461838 19.319878634387898)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.94031226634979 19.320341836687867)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.92994821071625 19.314208729366076)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.93913477659225 19.301083663618144)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.93878743052483 19.303010089266785)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.9731639623642 19.360898583305108)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.98500859737396 19.36665543227053)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-98.96645843982697 19.31164455149002)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.01979148387909 19.29509919537681)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Gerard86').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.15157914161682 19.432661187383577)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'ztirzo').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-99.157005 19.416523)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Hellerox').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.429146 20.63157)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Padbiker').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.407486 20.662613)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Padbiker').first.id, :kind => 1},
{:owned_object_id => Workshop.where('ST_GeomFromEWKB(coordinates) = ST_GeogFromText(?)', "POINT (-103.36481 20.684294)").first.id, :owned_object_type => 'Workshop', :user_id => User.where(:username => 'Ally1').first.id, :kind => 1}])