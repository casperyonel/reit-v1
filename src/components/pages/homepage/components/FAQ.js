import React from "react";
import Accordion from "./Accordion";

// import illustration__box from "../../../../assets/images/faq/illustration-box-desktop.svg";
// import illustration__woman_desktop from "../../../../assets/images/faq/illustration-woman-online-desktop.svg";
import illustration__woman_desktop from "../../../../assets/images/faq/monopoly-man.png";
import illustration__woman_mobile from "../../../../assets/images/faq/monopoly-man.png";

const questionsAnswers = [
  {
    question: `What is REIT DAO?`,
    answer:
      "REIT DAO is a Metaverse Land Investment DAO operating under the game mechanics of monopoly.",
  },
  {
    question: `What is Magic Monopoly Money $MMM?`,
    answer:
      "$MMM is the native token of REIT DAO, and is used to participate in monopoly.",
  },
  {
    question: `What is Magic Internet Land $MIL?`,
    answer:
      "$MIL is claimed when $MMM is staked. $MIL represents your share of the REIT DAO PCV.",
  },
  {
    question: "What is PCV?",
    answer: `"PCV" stands for Protocol Controlled Value, representing all of the assets REIT DAO owns.`,
  },
  {
    question: "Who is the team behind REIT DAO?",
    answer: `We are a group of DeFi builders interested in democratizing access to metaverse land.`,
  }
];

const FAQ = () => {
  return (
    <div className="container faq-styling">
      <div className="component">
        <div className="illustration">
         
          <img
            className="illustration__woman-desktop"
            src={illustration__woman_desktop}
            alt="illustration with woman"
          />
          <img
            className="illustration__woman-mobile"
            src={illustration__woman_mobile}
            alt="illustration with woman"
          />
        </div>
        <Accordion questionsAnswers={questionsAnswers} />
      </div>
       
    </div>
  );
};

export default FAQ;