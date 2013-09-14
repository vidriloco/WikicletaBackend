#encoding: utf-8

BikeBrand.create(:name => "Dahon")
BikeBrand.create(:name => "Brompton")
BikeBrand.create(:name => "Bamboocycles")
BikeBrand.create(:name => "Specialized")
BikeBrand.create(:name => "GIANT")
BikeBrand.create(:name => "Benotto")
BikeBrand.create(:name => "Electra")
BikeBrand.create(:name => "Pashley")
BikeBrand.create(:name => "Strida")
BikeBrand.create(:name => "Felt")
BikeBrand.create(:name => "Brooks")
BikeBrand.create(:name => "Tenere")
BikeBrand.create(:name => "Orbea")
BikeBrand.create(:name => "Cannondale")
BikeBrand.create(:name => "Tenere")
BikeBrand.create(:name => "Alubike")
BikeBrand.create(:name => "Trek")
BikeBrand.create(:name => "Turbo")
BikeBrand.create(:name => "Merida")
BikeBrand.create(:name => "Scott")
BikeBrand.create(:name => "Globe")
BikeBrand.create(:name => "Fuji")
BikeBrand.create(:name => "Haro")
BikeBrand.create(:name => "Cervelo")
BikeBrand.create(:name => "BH")
BikeBrand.create(:name => "Otra")

#df=City.create(:code => "mx_df", :coordinates => "POINT(-99.133286 19.432676)")
#gdl=City.create(:code => "mx_guadalajara", :coordinates => "POINT(-103.3519 20.6661)")
#City.create(:code => "mx_monterrey", :coordinates => "POINT(-100.3000 25.6667)")
#City.create(:code => "mx_aguascalientes", :coordinates => "POINT(-102.2911 21.8842)")

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



