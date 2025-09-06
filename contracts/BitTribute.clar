;; Title: BitTribute - Bitcoin-Native Social Economy Platform
;;
;; Summary:
;; A revolutionary Bitcoin Layer-2 protocol that transforms digital social 
;; interactions into measurable value through algorithmic reputation mining, 
;; creator monetization pathways, and NFT-based community governance on Stacks.
;;
;; Description:
;; BitTribute establishes the first truly decentralized social economy where 
;; authentic engagement generates real Bitcoin-backed rewards. Our protocol 
;; leverages Clarity smart contracts to create a trustless ecosystem where 
;; content creators, community members, and supporters can build sustainable 
;; digital economies through reputation-based value creation.
;;
;; Key Features:
;; - Dynamic reputation scoring with time-decay mechanics
;; - Multi-tier NFT membership system with exclusive benefits  
;; - Creator monetization through tips and engagement rewards
;; - Bitcoin-secured transparent governance
;; - Anti-spam protection with cooldown mechanisms
;; - Scalable social interaction infrastructure
;;
;; Built on Stacks, Secured by Bitcoin, Powered by Community.

;; ERROR CONSTANTS

(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-ALREADY-EXISTS (err u101))
(define-constant ERR-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-BALANCE (err u103))
(define-constant ERR-INVALID-AMOUNT (err u104))
(define-constant ERR-INVALID-THRESHOLD (err u105))
(define-constant ERR-INVALID-TIER (err u106))
(define-constant ERR-COOLDOWN-ACTIVE (err u107))
(define-constant ERR-EXPIRED-REPUTATION (err u108))

;; PROTOCOL CONSTANTS

(define-constant CONTRACT-OWNER tx-sender)
(define-constant REPUTATION-DECAY-PERIOD u144) ;; ~24 hours in blocks
(define-constant ENGAGEMENT-COOLDOWN u6) ;; ~1 hour in blocks  
(define-constant MIN-TIP-AMOUNT u1000000) ;; 1 STX minimum tip
(define-constant MAX-REPUTATION-SCORE u10000) ;; Reputation ceiling

;; STATE VARIABLES

(define-data-var contract-paused bool false)
(define-data-var total-reputation-nfts uint u0)
(define-data-var total-membership-nfts uint u0)

;; NFT DEFINITIONS

(define-non-fungible-token bittribute-reputation uint)
(define-non-fungible-token bittribute-membership uint)

;; DATA STORAGE MAPS

(define-map user-profiles
  principal
  {
    reputation-score: uint,
    last-activity-block: uint,
    total-earnings: uint,
    engagement-count: uint,
    reputation-nft-id: (optional uint),
    membership-nft-id: (optional uint),
  }
)

(define-map creator-settings
  principal
  {
    earnings-threshold: uint,
    reward-per-engagement: uint,
    is-active: bool,
    total-distributed: uint,
  }
)