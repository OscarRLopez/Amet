import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";

// @material-ui/icons
import Chat from "@material-ui/icons/Chat";
import VerifiedUser from "@material-ui/icons/VerifiedUser";
import Fingerprint from "@material-ui/icons/Fingerprint";
// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import InfoArea from "components/InfoArea/InfoArea.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/productStyle.js";

const useStyles = makeStyles(styles);

export default function ProductSection() {
  const classes = useStyles();
  return (
    <div className={classes.section}>
      <GridContainer justify="center">
        <GridItem xs={12} sm={12} md={8}>
          <h2 className={classes.title}>¿Por qué utilizar Amet?</h2>
          <h5 className={classes.description}>
            Amet es un portal hecho específicamente para la creación de eventos.
            Puedes organizar eventos pequeños como una reunión de amigos, o ex-compañeros de escuela,
            hasta eventos grandes como bodas, XV años, etc.
          </h5>
        </GridItem>
      </GridContainer>
      <div>
        <GridContainer>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Contacto directo"
              description="Una vez creado tu evento, podrás contactar a los proveedores de manera directa para ver detalles sobre tu evento."
              icon={Chat}
              iconColor="info"
              vertical
            />
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Proveedores verificados"
              description="Amet realiza un proceso de verificación para asegurarnos que los proveedores son reales y dan un servicio de calidad."
              icon={VerifiedUser}
              iconColor="success"
              vertical
            />
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Seguridad"
              description="Nuestro sistema de seguridad asegura que solo el organizador puede ver los detalles sobre el evento, los proveedores solo verán información relevante a su servicio."
              icon={Fingerprint}
              iconColor="danger"
              vertical
            />
          </GridItem>
        </GridContainer>
      </div>
    </div>
  );
}
