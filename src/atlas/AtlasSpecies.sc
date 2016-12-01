import $ivy.`org.json4s:json4s-native_2.11:3.5.0`
import org.json4s._
import org.json4s.native.JsonMethods._
import org.json4s.JsonDSL._
import $file.^.property.AnnotationSource
import $file.^.property.Species
import $file.^.util.Combinators

case class AtlasSpecies(species: String, defaultQueryFactorType: String, kingdom: String, resources: List[(String, List[String])]) {
  val json =
    ("name" -> this.species) ~
    ("defaultQueryFactorType" -> this.defaultQueryFactorType) ~
    ("kingdom" -> this.kingdom) ~
    ("resources" ->
      this.resources.map { case (rType, rValues) =>
        (("type" -> rType) ~
         ("urls" -> rValues))})

  def toJson: String = pretty(render(json))
}

object AtlasSpeciesFactory {
  val defaultQueryFactorTypesMap = Map("parasite" -> "DEVELOPMENTAL_STAGE")

  val kingdomMap =
    Map("ensembl" -> "animals",
        "metazoa" -> "animals",
        "fungi" -> "fungi",
        "parasite" -> "animals",
        "plants" -> "plants")

  val resourcesMap =
    Map("genome browser" ->  Map("ensembl" -> List("http://www.ensembl.org/"),
                                  "metazoa" -> List("http://metazoa.ensembl.org/"),
                                  "fungi" -> List("http://fungi.ensembl.org/"),
                                  "parasite" -> List("http://parasite.wormbase.org/"),
                                  "plants" -> List("http://plants.ensembl.org/", "http://ensembl.gramene.org/"))
    )

  def create(species: String) = {
    AnnotationSource.getValues(species, List("databaseName", "mySqlDbName"))
    .right.map {
      case List(databaseName, mySqlDbName) =>
        AtlasSpecies(
          species,
          defaultQueryFactorTypesMap.get(databaseName).getOrElse("ORGANISM_PART"),
          kingdomMap.get(databaseName).getOrElse(""),
          resourcesMap.toList.map {
            case (key, values) => (key, values.get(databaseName).getOrElse(List()).map(_ + mySqlDbName))
          }
        )
    }
  }
}

// object Main extends App {
def dump(path:ammonite.ops.Path) = {
  Combinators.combine(Species.allSpecies.map(AtlasSpeciesFactory.create))
  .right.map(_.map(_.toJson).mkString(",\n"))
  .right.map{case txt => s"[${txt}]"} match {
    case Right(res)
      => ammonite.ops.write(path, res)
    case Left(err)
      => print(err)
  }
}
